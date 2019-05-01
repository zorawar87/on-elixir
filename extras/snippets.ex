true, false
!, ==, !=, >, <, ===
"1+1 = #{1+1}" ==  "1+1 = 2"
"hello " <> "world", String.split, String.replace, String.contains?, String.reverse, String.trim, Stirng.duplicate, String.upcase, 
int to list Integer.digits(), list to int Integer.undigit
first..last = Range.new(1,100)
atoms = constants where name is the value, eg. bool, nil

DS: Tuple, List, KWList, Map %{}, MapSet
{}, [] are Heterogenous 
[1,2] ++ [:new_elem]
KW List is syntactic sugar for [{:a, ""}]



pipe operator, immutability
===========================

Alerts.all
|> filter_by_date(Timex.today)
|> filter_by_route("Red")
|> filter_by_stop("Porter Square")

Credit: MBTA


Async/Parallel fetching
=======================

alerts_task = Task.async(&Alerts.all/0)
routes_task = Task.async(&Routes.all/0)


Pattern Matching
=====================

def full_name(:subway, name), do: "#{name} Line"
def full_name(:bus, name}), do: "Route #{name}"

"Red Line" = full_name(:subway, “Red”)
"Route 5" = full_name(:bus, 5)

full_name(:rocketship, “Orion”) (raises exception)


def full_name(mode, name) do
  if mode == :subway do
    "#{name} Line"
  else if mode == :bus do
    "Route #{name}"
  else
    raise ArgumentError, message: "unknown mode #{mode}"
  end
end


Distribution: RPCs
===================
> iex --sname foo
(foo@blade)> Hello.world
>> ERROR
(foo@blade)> Node.spawn_link :bar@zm, fn -> Hello.world end
>> Hello world
#PID<11477.126.0>
---------------
(foo@blade)> Hello.world
>> Hello world
:ok


> iex --sname bar
(bar@blade)> contents =
defmodule Hello do
def world do
IO.puts "Hello world"
end
end
(bar@blade)> Hello.world
>> Hello
:ok
---------------

(bar@blade)> {:module, _, bytecode, _} = contents
(bar@blade)> :rpc.call :foo@blace, :code, :load_binary, [Hello, 'iex', bytecode]
# 'iex' is the file it was defined in

