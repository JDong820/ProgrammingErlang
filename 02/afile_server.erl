-module(afile_server).
-export([start/1, loop/1]).

start(Dir) -> spawn(afile_server, loop, [Dir]).

loop(Dir) ->
    receive
        {Client, list_dir} ->
            Client ! {self(), file:list_dir(Dir)};
        {Client, {get_file, File}} ->
            Fullpath = filename:join(Dir, File),
            Client ! {self(), file:read_file(Fullpath)};
        {Client, {put_file, Filename, Data}} ->
            Fullpath = filename:join(Dir, Filename),
            {ok, FD} = file:open(Fullpath, [raw, write, delayed_write]),
            file:write(FD, Data),
            Client ! {self(), {ok, Filename}}
    end,
    loop(Dir).
