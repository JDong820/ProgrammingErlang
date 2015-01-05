-module(yafs).
%-export([start/0]).
-compile(export_all).

%
% Write a file server using lib_chan.
% Add bells and whistles.
%

start(Dir) -> register(file_server, spawn(fun() -> loop(Dir) end)).

rpc(Q) ->
    file_server ! {self(), Q},
    receive
        {file_server, Value} ->
            Value
    after 3000 ->
              timeout
    end.

loop(Dir) ->
    receive
        {Client, list_dir} ->
            Client ! {file_server, file:list_dir(Dir)};
        {Client, {get_file, File}} ->
            Fullpath = filename:join(Dir, File),
            Client ! {file_server, file:read_file(Fullpath)};
        {Client, {put_file, Filename, Data}} ->
            Fullpath = filename:join(Dir, Filename),
            {ok, FD} = file:open(Fullpath, [raw, write, delayed_write]),
            file:write(FD, Data),
            Client ! {file_server, {ok, Filename}}
    end,
    loop(Dir).
