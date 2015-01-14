(*  Assignment #1 *)
(*"hello world"*)

type DATE  = {year:int, month:int, day: int}
exception invalidparameter

(* this file is where your solutions go *)
(*1*)
fun is_older(d1: DATE, d2: DATE): bool =
    if(#year d1 >  #year d2)
	  then true
    else if(#year d1 = #year d2 andalso #month d1 > #month d2)
	  then true
    else if(#year d1 = #year d2 andalso #month d1 = #month d2 andalso #day d1 > #day d2)
	  then true
    else false

(*2*)
fun number_in_month(dates: DATE list, month: int): int =
    if(null dates)
	  then 0
    else if((#month (hd dates)) = month)
	then 1 + number_in_month(tl dates, month)
    else number_in_month(tl dates, month)

(*3*)
fun number_in_months(dates: DATE list, months: int list): int =
    if(null months)
	  then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months)

(*4*)
fun dates_in_month(dates: DATE list, month: int): DATE list =
    if(null dates)
	  then []
    else if((#month (hd dates)) = month)
	  then (hd dates)::dates_in_month((tl dates), month)
    else dates_in_month((tl dates), month)

(*5*)
fun dates_in_months(dates: DATE list, months: int list): DATE list =
    if(null months)
	  then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

(*6*)
fun get_nth(slist: string list, n: int): string =
    if(null slist orelse n = 0)
	  then raise invalidparameter
    else if(n = 1)
	  then hd slist
    else get_nth(tl slist, (n-1))

(*7*)
fun date_to_string(
(*
val test6 = get_nth(["hi", "there", "how", "are", "you"], 2) = "there"
TESTING
    type DATE = {day:int, month:int, year:int}
    exception InvalidParameter
    val is_older = fn : DATE * DATE -> bool
    val number_in_month = fn : DATE list * int -> int
    val number_in_months = fn : DATE list * int list -> int
    val dates_in_month = fn : DATE list * int -> DATE list
    val dates_in_months = fn : DATE list * int list -> DATE list
val get_nth = fn : string list * int -> string
val date_to_string = fn : DATE -> string
val number_before_reaching_sum = fn : int * int list -> int
val what_month = fn : int -> int
val month_range = fn : int * int -> int list
val oldest = fn : DATE list -> DATE option
val reasonable_date = fn : DATE -> bool

*)
