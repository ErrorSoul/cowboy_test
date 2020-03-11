-module(half_handler).
-export([init/2]).



init(Req0, State) ->
    error_logger:info_msg('IM   dfdfdfasdfaf adf '),
    Id = cowboy_req:binding(id, Req0),
    error_logger:info_msg('Id is .... ~p ', [Id]),
    error_logger:info_msg('Conn is .... ~p ', [dconn]),
    insert_to_db(Id),
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"text/plain">>},
        "HE ___ )))))))))))" ++ "_   " ++  Id,
        Req0),
    {ok, Req, State}.


insert_to_db(ID) ->
  %% {ok, Conn} = epgsql:connect("db", "example", "example",
  %%     #{database => "example", timeout => 10}
  %%   ),
  Message = string:join(["my_message is", binary_to_list(ID)], " "),
  Squery = string:join(["insert into score(message) values('", Message ,"');"], " "),
  error_logger:info_msg('to redis ~p ', [["SET", erlang:system_time(seconds), Squery]]),
  X = ["SET", erlang:system_time(seconds), Squery],
  {R, Num} = db_psgrsql ! {query, X},
  %epgsql:close(Conn),
  error_logger:info_msg('SQL RESULT is is .... ~p ', [{R, Num}]),
  {R, Num}.


%%insert_to_db(ID) ->
%%   {ok, C} = epgsqla:start_link(),
%%   Ref = epgsqla:connect(C, "database", "postgres", #{database => "docker"}),
%%   receive
%%     {C, Ref, connected} ->
%%         {ok, C};
%%     {C, Ref, Error = {error, _}} ->
%%         Error;
%%     {'EXIT', C, _Reason} ->
%%         {error, closed}
%%   end.


%% {ok, Conn} = epgsql:connect("database", "postgres",
  %%     #{database => "docker", timeout => 100}
  %%   ),
%% SELECT * FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema';"
