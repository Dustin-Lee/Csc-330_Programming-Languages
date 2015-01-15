(*  Assignment #1 *)
(*"hello world"*)

type DATE  = {year:int, month:int, day: int}
exception InvalidParameter

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
	  then raise InvalidParameter
    else if(n = 1)
	  then hd slist
    else get_nth(tl slist, (n-1))

(*7*)
fun date_to_string(d1: DATE): string =
    let val l = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
	get_nth(l, #month d1) ^" "^ Int.toString(#day d1) ^", "^ Int.toString(#year d1)
    end

(*8*)
fun number_before_reaching_sum(sum: int, ilist: int list): int =
    if(hd ilist >= sum)
	  then 0
    else 1 + number_before_reaching_sum((sum-(hd ilist)), tl ilist)

(*9*)
fun what_month(day: int): int =
    let val day_sum = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
	number_before_reaching_sum(day, day_sum) + 1
    end


(*10*)
fun month_range(d1: int, d2: int): int list =
    if(d1>d2)
    then []
    else
	let fun m_recur(start: int, fin: int): int list =
	    if(start > fin)
		  then []
	    else what_month(start)::m_recur((start+1), fin)
	in
	    m_recur(d1, d2)
	end

(*11*)
fun oldest(dlist: DATE list)(*: DATE option *)=
    if(null dlist)
         then NONE
    else let fun old_date(olist: DATE list)(*: DATE option *)=
	 if(null (tl olist))
	       then (hd olist)
	 else
	     let val recurs_ans = old_date(tl olist)
	     in
		 if(is_older((hd olist),(recurs_ans)))
	         then hd olist
		 else recurs_ans
	     end
    in
	SOME (old_date dlist)
    end
	  


(*12*)
(*  val test11a = oldest([april28_2011]) = SOME april28_2011
    val test11b = oldest([]) = NONE
    val test11 = oldest([feb28_2012,march31_2011,april28_2011]) = SOME feb28_2012
fun better_max2 (xs : int list) =
 if null xs
 then NONE
 else let (* ok to assume xs nonempty b/c local *)
        fun max_nonempty (xs : int list) =
          if null (tl xs)
          then hd xs
          else
            let val tl_ans = max_nonempty(tl xs)
            in
              if hd xs > tl_ans
              then hd xs
              else tl_ans
            end
      in
          SOME (max_nonempty xs)
      end

###

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
