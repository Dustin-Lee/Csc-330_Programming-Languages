(* if you use this function to compare two strings (returns true if the same
   string), then you avoid some warning regarding polymorphic comparison  *)

fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for Part 1 here *)
fun all_except_option(s1: string, lst: string list) =
    case lst of
	[]  => NONE
      | x::xl => if(same_string(s1, x))
		 then SOME xl
		 else
		     case all_except_option(s1, xl) of
			 NONE => NONE
		       | SOME l => SOME (x::l)
(*		     SOME (x::all_except_option(s1, xl))   *)


		      (* if(lst = [])
			 then acc
			 else if(same_string(s1, x))
			 then tRec_func(s1, xl, acc) (*SOME xl*)(*If it is the first element*)
			 else
			     tRec_func(s1, xl, acc@(x::[]))(*appends to the end*)
    in
	SOME (tRec_func(s1, lst, [])) (*Problem?*)
    end
                      *)

(*
    case lst of
	[] => NONE
      | x::xl => if same_string(s1, x)
		 then SOME xl(*If it is the first element*)
		 else 
*)

(*let fun is_a_lst(s1, xlst) =*)
			  
	

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
