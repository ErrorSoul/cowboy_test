-module(hello_erlang_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
  {ok, Conn} = epgsql:connect("database", "postgres",
      #{database => "docker", timeout => 10}
  ),
  register(dconn, Conn),
	Procs = [],
	{ok, {{one_for_one, 1, 5}, Procs}}.
