-module(hello_erlang_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1, my_db/1]).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
  %% {ok, Conn} = epgsql:connect("db", "docker", "docker",
  %%     #{database => "docker", timeout => 10}
  %% ),

  {ok, Conn} = eredis:start_link("redis", 6379),
  register(dconn, Conn),
  DB = spawn(?MODULE, my_db, [dconn]),
  register(db_psgrsql, DB),
	Procs = [],
	{ok, {{one_for_one, 1, 5}, Procs}}.


my_db(DBconn) ->
  receive
    {query, Squery} ->
      {R, Num} = eredis:q(DBconn, Squery),
      my_db(DBconn),
      {R, Num}
  end.
