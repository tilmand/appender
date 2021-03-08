File appender
=====================================

String appending by the file path.

Build
-----

Compile and run locally.

```sh
$ rebar compile
$ erl -pa ebin -eval "application:start(appender)"
```

API
-------

For appending string to file run in console:

```sh
$ data:add(FilePath, String).
```
