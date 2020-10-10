%%%-------------------------------------------------------------------
%%% @author sulongx
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%% @end
%%%-------------------------------------------------------------------
-module(sc_sup).

-behaviour(supervisor).

-export([start_link/0, init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    ElementSup = #{id => sc_element_sup,
        start => {sc_element_sup, start_link, []},
        restart => permanent,
        shutdown => 2000,
        type => supervisor,
        modules => [sc_element]},

    EventManage = #{id => sc_event,
        start => {sc_event, start_link, []},
        restart => permanent,
        shutdown => 2000,
        type => worker,
        modules => [sc_event]
    },

    {ok, {#{strategy => one_for_one,
        intensity => 4,
        period => 3600},
        [ElementSup, EventManage]}
    }.
