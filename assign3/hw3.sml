(* Assign 03 Provided Code *)

(*  Version 1.0 *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let
	val r = g f1 f2
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end


(**** put all your code after this line ****)

(*1*)
fun only_capitals(s1: string list): string list =
    List.filter (fn s => Char.isUpper(String.sub(s,0))) s1

(*2*)
fun longest_string1(sl:string list): string =
    List.foldl (fn (s1,s2) => if String.size s1 > String.size s2 then s1 else s2) "" sl

(*3*)
fun longest_string2(sl:string list): string =
    List.foldl (fn (s1,s2) => if String.size s1 >= String.size s2 then s1 else s2) "" sl

(*4*)
fun longest_string_helper comp_str slist =
    List.foldl (fn (s1,s2) => if comp_str(String.size s1, String.size s2) then s1 else s2) "" slist
    

fun longest_string3 sl =
    longest_string_helper (fn (x,y) => x>y) sl

fun longest_string4 sl =
    longest_string_helper (fn (x,y) => x>=y) sl

(*5*)
fun longest_capitalized(sl): string =
    (longest_string1 o only_capitals) sl

(*6*)
fun rev_string(s): string =
    (String.implode o List.rev o String.explode) s

(*7*)
fun first_answer func some_list =
    case some_list of
	[] => raise NoAnswer
      | x::xl => case func x of
		     NONE => first_answer func xl
		   | SOME v => v

(*8*)
fun all_answers func some_list =
    let
	fun all_answers_helper(some_list, acc) =
	    case some_list of
		[] => SOME acc
	      | x::xl => case func x of
			     NONE => NONE
			   | SOME v => all_answers_helper(xl, acc@v)
    in
	all_answers_helper(some_list, [])
    end

(*9*)
	(*a*)
	(*g is in curried form and takes two functions, f1 and f2, and another
          parameter p. Then for whatever case of p, is how it decides what
          to return for:
          Wildcard: returns an empty list of bindinds
          Variable x: returns a single element list holding alpha type of (s,v)
          TupleP ps: returns a list
          ConstructorP(_,p): returns a list of pattern matchs
          _: returns 0
          *)


      (*b*)
fun count_wildcards(pattern) =
    g (fn s => 1) (fn x => 0) pattern

      (*c*)
fun count_wild_and_variable_lengths(pat) =
    g (fn s => 1) (fn s => String.size s) pat

      (*d*)
fun count_some_var(s, p) =
    g (fn x => 0) (fn x => if s=x then 1 else 0) p

(*10*)
