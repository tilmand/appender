-module(data_tests).
-include_lib("eunit/include/eunit.hrl").

add_test() ->
  ets:new(file_pids, [set, public, named_table]),
  TestFile = "test1.txt",
  file:write_file(TestFile,[]),
  ?assertEqual(ok, data:add(TestFile, "some data")),
  file:delete(TestFile).

add_not_exists_test() ->
  ?assertEqual(not_exists, data:add("test5.txt", "some data")).

is_same_pid_test() ->
  TestFile = "test1.txt",
  file:write_file(TestFile,[]),
  ok = data:add(TestFile, "some data"),
  [{_, Pid1, _}] = ets:lookup(file_pids, TestFile),
  timer:sleep(3*1000),
  ok = data:add(TestFile, "some data"),
  [{_, Pid2, _}] = ets:lookup(file_pids, TestFile),
  file:delete(TestFile),
  ?assertEqual(Pid1, Pid2).
