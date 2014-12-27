-module(config_loader).
-export([load_json_config/1, validate_config/1]).

test_validation() ->
    config_ok = validate_config(#{}), % help
    validation_tests_passed.

load_json_config(Filename) ->
    maps:from_json(file:read_file(Filename)). %% lies. TODO: install jiffy. rebar?

validate_config(Map) -> % help
    {ok, Username} = maps:find("username", Map),
    true = io_lib:printable_unicode_list(Username),
    {ok, Name} = maps:find("name", Map),
    true = io_lib:printable_unicode_list(Name),
    {ok, Email} = maps:find("email", Map),
    true = io_lib:printable_unicode_list(Email),
    {ok, Password} = maps:find("password", Map),
    true = io_lib:printable_unicode_list(Password),
    {ok, Autologin} = maps:find("autologin", Map),
    true = is_boolean(Autologin),
    config_ok.
