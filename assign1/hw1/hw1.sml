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


(*
TESTING

*)
