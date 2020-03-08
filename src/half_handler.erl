-module(half_handler).
-export([init/2]).



init(Req0, State) ->
    error_logger:info_msg('IM   dfdfdfasdfaf adf '),
    Id = cowboy_req:binding(id, Req0),
    error_logger:info_msg('Resa is .... ~p ', [Id]),
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"text/plain">>},
        "HE ___ )))))))))))" ++ "_   " ++  Id,
        Req0),
    {ok, Req, State}.
