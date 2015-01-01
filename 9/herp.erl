-module(herp).
-export([get_docstring/1]).
-import(pydoc, [get_python_docstring/1]).


get_docstring(Filepath) ->
    [Extension|_] = lists:reverse(string:tokens(Filepath, ".")),
    case Extension of
        "py" -> element(2, get_python_docstring(Filepath))
    end.
