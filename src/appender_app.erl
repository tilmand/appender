-module(appender_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    ets:new(file_pids, [set, public, named_table]),
    appender_sup:start_link().

stop(_State) ->
    ets:delete(file_pids),
    ok.
