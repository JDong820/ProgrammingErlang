-module(pydoc).
-export([get_python_docstring/1]).

-type encoding() :: atom().
-opaque doc_string() :: {encoding(), string()}.
-export_type([doc_string/0]).


-spec get_python_docstring(string()) -> doc_string().

get_encoding(Data) ->
    utf8. % Being lazy.

get_docstring(Data) ->
    [Docstring, _] = string:tokens(Data, "\""),
    Docstring. % Probably doesn't work.

get_python_docstring(Filepath) ->
    Data = file:read_file(Filepath),
    {ok, Bin} = Data,
    Text = binary_to_term(Bin),
    [Lead|_] = Text,
    if 
        Lead =:= $# -> {get_encoding(Text), get_docstring(Text)};
        true -> {utf8, get_docstring(Text)} % default case
    end.
