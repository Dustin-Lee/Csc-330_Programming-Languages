(*Dustin Chang*)
type name = {first:string, last:string, middle:string}

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

(*4*)
fun similar_names(sll: string list list, nam) =
    let 
	fun helper(sl: string list, nam, acc) =
	    case sl of
		[] => acc
	      | x::xl => case nam of
			    {first,middle,last} => helper(xl, nam, acc@[{first=x, middle=middle, last=last}])
    in
	case nam of
	    {first:string,middle:string,last:string} => helper(first::get_substitutions2(sll,first), nam, [])
    end




(*TESTING
    let fun helper(sll: string list list, nam: name, acc) =
	    case nam of
		{} => []
	      | {x,y,z} => case get_substitutions2(sll, x)
				[] => {x,z,y}@acc
			      | s:sl => helper(slacc@{s,z,y}



case sll of
			       [] => {x,z,y}@acc {x,z,y} | {x,z,y}@acc) inside a function and call with empty record
			     | s::sl => helper(


case get_substitutions2(sll, x) of
			       [] => []
			     | s::sl => 

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
