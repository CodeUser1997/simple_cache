%%%-------------------------------------------------------------------
%%% @author sulongx
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 10月 2020 4:51 下午
%%%-------------------------------------------------------------------
-module(sc_event).
-author("sulongx").


%% API
-export([start_link/0,
    add_handler/2,
    delete_handler/2,
    lookup/1,
    create/2,
    replace/2,
    delete/1]).

%% gen_event callbacks


-define(SERVER, ?MODULE).

-record(sc_event_state, {}).

%%%===================================================================
%%% gen_event callbacks
%%%===================================================================

%% @doc Creates an event manager
start_link() ->
    gen_event:start_link({local, ?SERVER}).

%% @doc Adds an event handler
add_handler(Handler, Args) ->
    gen_event:add_handler(?SERVER, Handler, Args).

delete_handler(Handler, Args) ->
    gen_event:delete_handler(?SERVER, Handler, Args).

lookup(Key) ->
    gen_event:notify(?SERVER, {lookup, Key}).

create(Key, Value) ->
    gen_event:notify(?SERVER, {create, {Key, Value}}).

replace(Key, Value) ->
    gen_event:notify(?SERVER, {replace, {Key, Value}}).

delete(Key) ->
    gen_event:notify(?SERVER, {delete, Key}).

%%%===================================================================
%%% gen_event callbacks
%%%===================================================================


%%%===================================================================
%%% Internal functions
%%%===================================================================
