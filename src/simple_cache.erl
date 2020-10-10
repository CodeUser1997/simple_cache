%%%-------------------------------------------------------------------
%%% @author sulongx
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. 10月 2020 5:19 下午
%%%-------------------------------------------------------------------
-module(simple_cache).
-author("sulongx").

%% API
-export([insert/2, lookup/1, delete/1]).


insert(Key, Value) ->
    case sc_store:lookup(Key) of
        {ok, Pid} ->
            sc_element:replace(Pid, Value),
            sc_event:replace(Pid, Value);
        {error, _} ->
            {ok, Pid} = sc_element:create(Value),
            sc_store:insert(Key, Pid),
            sc_event:create(Key, Value)
    end.

lookup(Key) ->
    try
        {ok, Pid} = sc_store:lookup(Key),
        {ok, Value} = sc_element:fetch(Pid)
    catch
        _Class:_Exception  ->
            {error, not_found}
    end.

delete(Key) ->
    case sc_store:lookup(Key) of
        {ok, Pid} ->
            sc_event:delete(Pid),
            sc_element:delete(Pid);
        {error,_Reason} ->
            ok
    end.
