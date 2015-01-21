(* if you use this function to compare two strings (returns true if the same
   string), then you avoid some warning regarding polymorphic comparison  *)

fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for Part 1 here *)
(*1*)
fun all_except_option(s1: string, lst: string list) =
    case lst of
	[]  => NONE
      | x::xl => if(same_string(s1, x))
		 then SOME xl
		 else
		     case all_except_option(s1, xl) of
			 NONE => NONE
		       | SOME l => SOME (x::l)

(*2*)
fun get_substitutions1(sll: string list list, s: string): string list =
    case sll of
	[] => []
      | x::xl => case all_except_option(s, x) of
			 NONE => get_substitutions1(xl, s)
		       | SOME l => l@get_substitutions1(xl, s)

(*3*)
fun get_substitutions2(sll: string list list, s: string): string list =
    let fun recur(sll: string list list, s: string, acc: string list): string list =
	    case sll of
		[] => acc
	      | x::xl => case all_except_option(s, x) of
			     NONE => recur(xl, s, acc)
			   | SOME l => recur(xl, s, acc@l)
    in
	recur(sll, s, [])
    end



(*
if(all_except_option(s, lst))
	       then 
	       else
*)


			  
	

(************************************************************************)
(* Game  *)

(* you may assume that Num is always used with valid values 2, 3, ..., 10 *)

datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw


exception IllegalMove

(* put your solutions for Part 2 here *)
