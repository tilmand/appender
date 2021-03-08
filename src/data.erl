-module(data).

-export([add/2, delete/2]).

-define(TTL, 10).

add(FilePath, String) ->
  case filelib:is_file(FilePath) of
    true ->
      Ttl = os:system_time(seconds) + ?TTL,
      case ets:lookup(file_pids, FilePath) of
        [] ->
          {ok, Pid} = file:open(FilePath, [append]),
          true = ets:insert(file_pids, {FilePath, Pid, Ttl});
        [{FilePath, Pid, _}] ->
          true = ets:insert(file_pids, {FilePath, Pid, Ttl})
      end,
      io:format(Pid, "~p~n" ,[String]),
      true = ets:insert(file_pids, {FilePath, Pid, Ttl}),
      timer:apply_after(3*1000, data, delete, [Pid, FilePath]),
      ok;
    false ->
      not_exists
  end.

delete(Pid, FilePath) ->
  case ets:lookup(file_pids, FilePath) of
    [{_, _, Ttl}] ->
      case os:system_time(seconds) > Ttl of
        true ->
          ets:delete(file_pids, FilePath),
          file:close(Pid);
        false ->
          ok
      end;
    _ ->
      ok
  end.
