%%%-------------------------------------------------------------------
%%% @author sulongx
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 10月 2020 5:41 下午
%%%-------------------------------------------------------------------
-module(sc_event_logger).
-author("sulongx").

-behaviour(gen_event).

%% API
-export([add_handler/0, delete_handler/0]).

%% gen_event callbacks
-export([init/1, handle_event/2, handle_call/2, handle_info/2, terminate/2,
    code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {}).

%%%===================================================================
%%% gen_event callbacks
%%%===================================================================


%% @doc Adds an event handler
add_handler() ->
    sc_event:add_handler(?SERVER,[]).

delete_handler() ->
    sc_event:delete_handler(?SERVER, []).

%%%===================================================================
%%% gen_event callbacks
%%%===================================================================

%% @private
%% @doc Whenever a new event handler is added to an event manager,
%% this function is called to initialize the event handler.
init([]) ->
    {ok, #state{}}.

%% @private
%% @doc Whenever an event manager receives an event sent using
%% gen_event:notify/2 or gen_event:sync_notify/2, this function is
%% called for each installed event handler to handle the event.
handle_event({create, {Key, Value}}, State) ->
    error_logger:info_msg("create(~w, ~w)~n", [Key, Value]),
    {ok, State};
handle_event({lookup, Key}, State) ->
    error_logger:info_msg("lookup(~w)~n", Key),
    {ok, State};
handle_event({delete, Key}, State) ->
    error_logger:info_msg("delete(~w)~n", Key),
    {ok, State};
handle_event({replace, {Key, Value}}, State) ->
    error_logger:info_msg("replace(~w, ~w)~n", [Key, Value]),
    {ok, State}.

%% @private
%% @doc Whenever an event manager receives a request sent using
%% gen_event:call/3,4, this function is called for the specified
%% event handler to handle the request.
handle_call(_Request, State) ->
    Reply = ok,
    {ok, Reply, State}.

%% @private
%% @doc This function is called for each installed event handler when
%% an event manager receives any other message than an event or a
%% synchronous request (or a system message).
handle_info(_Info, State) ->
    {ok, State}.

%% @private
%% @doc Whenever an event handler is deleted from an event manager, this
%% function is called. It should be the opposite of Module:init/1 and
%% do any necessary cleaning up.
terminate(_Arg, _State) ->
    ok.

%% @private
%% @doc Convert process state when code is changed
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
