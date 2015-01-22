(*Dustin Chang*)

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
(*5*)
fun card_color(c1: card): color =
    case c1 of
	(suit, rank) => if(suit = Spades orelse suit = Clubs)
			      then Black
			else
			    Red

(*6*)
fun card_value(c1: card): int =
    case c1 of
	(_,Ace) => 11
      | (_,Num x) => x
      | (_,KQJ) => 10

(*7*)
fun remove_card([]: card list, c: card, e: exn): card list = raise e
  | remove_card(c1::cl: card list, c: card, e: exn): card list =
    case c1=c of
	true => cl
      | false => c1::remove_card(cl, c, e)

(*8*)
fun all_same_color([]: card list): bool = true
  | all_same_color([single]: card list): bool = true (*Only one card so true*)
  | all_same_color(c::ct: card list): bool =
    case ct of
	[] => true
      | x::xt => case card_color(c)=card_color(x) of
		     true => all_same_color(ct)
		   | false => false

(*9*)
fun sum_cards(cl: card list): int =
    let
	fun helper(cl, acc): int =
	    case cl of
		[] => acc
	      | c::tail => helper(tail, card_value(c)+acc)
    in
	helper(cl, 0)
    end

(*10*)
fun score(cl: card list, goal: int): int =
    let
	fun calc(sum: int, goal: int): int =
	    case all_same_color(cl) of
		true => if(sum>goal)
			then (sum-goal)
			else (goal-sum) div 2
	      | false => if(sum>goal)
			then (sum-goal)*2
			else goal-sum

    in
	calc(sum_cards(cl), goal)
    end

(*11*)
fun officiate(cl: card list, mov: move list, goal: int): int =
    let
	fun helper(cardList: card list, mov: move list, goal: int, held: card list, e: exn): int =
	    case mov of
		[] => score(held, goal)
	      | m::ml => if(sum_cards(held)>goal)
			 then score(held, goal)
			 else case m of
				  Discard crd => helper(cardList, ml, goal, (remove_card(held, crd, e)), e)
				| Draw => case cardList of
					      [] => score(held, goal)
					    | c::ct => helper(ct, ml, goal, (c::held), e)
    in
	helper(cl, mov, goal, [], IllegalMove)
    end
