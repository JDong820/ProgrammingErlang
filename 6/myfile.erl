-module(myfile).
-export([read/1, test_read/0]).

test_read() ->
    Caught = (catch myfile:read("/etc/shadow")),
    Caught = {unreadableFileError, "/etc/shadow"},
    {ok, [TestFile|_]} = file:list_dir("."), % Not perfect.
    true = is_binary(myfile:read(TestFile)),
    read_tests_passed.

read(File) ->
    case file:read_file(File) of
        {ok, Bin} -> Bin;
        {error, _} -> throw({unreadableFileError, File})
    end.
