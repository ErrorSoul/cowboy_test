PROJECT = hello_erlang
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.1.0

DEPS = cowboy epgsql eredis
dep_cowboy_commit = 2.7.0
DEP_PLUGINS = cowboy

include erlang.mk
