%%%-------------------------------------------------------------------
%%% @author sulongx
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 9月 2020 5:15 下午
%%%-------------------------------------------------------------------
{application, simple_cache, [
    {description, "cache applications implemented using Erlang"},
    {vsn, "0.1.0"},
    {modules,[
        simple_cache,
        sc_app,
        sc_sup,
        sc_element_sup,
        sc_store,
        sc_element,
        sc_event,
        sc_event_logger
    ]},
    {registered, [
        sc_sup,
        sc_element_sup,
        sc_event
    ]},
    {applications, [
        kernel,
        stdlib
    ]},
    {mod, {sc_app, []}},
    {env, []}
]}.
