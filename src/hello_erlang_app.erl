-module(hello_erlang_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
  Dispatch = cowboy_router:compile([
        {'_', [
               {"/x/:id", half_handler, []},

               {"/", hello_handler, []}
              ]}
    ]),
    {ok, _} = cowboy:start_clear(http_listener,
        [{port, 8080}],
        #{env => #{dispatch => Dispatch}}
    ),
	hello_erlang_sup:start_link().

stop(_State) ->
	ok = cowboy:stop_listener(http_listener).
