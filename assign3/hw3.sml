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
fun longest_string_helper (comp_str, slist) =
    List.foldl (fn (s1,s2) => if comp_str(String.size s1, String.size s2) then s1 else s2) "" slist
    

fun longest_string3 sl =
    let
	val comp_str = fn (x,y) => x>y
    in
	longest_string_helper (comp_str, sl)
    end

fun longest_string4 sl =
    let
	val comp_str = fn (x,y) => x>=y
    in
	longest_string_helper (comp_str, sl)
    end
