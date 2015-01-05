-module(datetime).
-export([]).
-record(date, {year, month, day}).
-record(time, {hour=0, minute=0, second=0}).
-record(datetime, {date, time}).
-record(timezone, {offset=0, name=none}).

%
% This is all wrong, see http://erldocs.com/current/stdlib/calendar.html
%

%
% Tests
%

% no tests :(

%
% Helper functions.
%

shift_datetime(Datetime, Timezone) ->
    error(not_implemented).

make_datetime(Timestamp) -> % Turn a UNIX timestamp into YMD, HMS datetime record.
    error(not_implemented).

%
% Exported functions.
%

today() -> % Return the current local datetime, with tzinfo None.
    datetime:now(#timezone{offset=0, name=none}).

now(TZ) ->
    shift_datetime(make_datetime(now()), element(1, TZ)).

utcnow(Datetime) ->
    erlang:localtime_to_universaltime(Datetime). % please
 
fromtimestamp(Timestamp) -> % Turn a UNIX timestamp to a datetime record.
    make_datetime(Timestamp).

utcfromtimestamp(Timestamp) ->
    error(not_implemented).

fromordinal(Ordinal) ->
    error(not_implemented).

combine(Date, Time) ->
    % #datetime{Date, Time}. please
    {Y, M, D} = Date,
    {Hr, Mi, Se} = Time,
    DateRecord = #date{year=Y, month=M, day=D},
    TimeRecord = #time{hour=Hr, minute=Mi, second=Se},
    #datetime{date=DateRecord, time=TimeRecord}.

strptime(date_string, format) ->
    error(not_implemented).
