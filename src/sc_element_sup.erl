%%%-------------------------------------------------------------------
%%% @author sulongx
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 9月 2020 5:18 下午
%%%-------------------------------------------------------------------
-module(sc_element_sup).
-author("sulongx").

-behaviour(supervisor).

%% API
-export([start_link/0, start_child/2]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%%===================================================================
%%% API functions
%%%===================================================================

%% @doc Starts the supervisor
-spec(start_link() -> {ok, Pid :: pid()} | ignore | {error, Reason :: term()}).
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

start_child(Value, LeaseTime) ->
    supervisor:start_child(?SERVER, [Value, LeaseTime]).

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================

%% @private
%% @doc Whenever a supervisor is started using supervisor:start_link/[2,3],
%% this function is called by the new process to find out about
%% restart strategy, maximum restart frequency and child
%% specifications.
init([]) ->
    MaxRestarts = 0,
    MaxSecondsBetweenRestarts = 1,
    SupFlags = #{strategy => simple_one_for_one,
        intensity => MaxRestarts,
        period => MaxSecondsBetweenRestarts},

    AChild = #{id => sc_element,
        start => {sc_element, start_link, []},
        restart => temporary,
        shutdown => brutal_kill,
        type => worker,
        modules => [sc_element]},

    {ok, {SupFlags, [AChild]}}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
