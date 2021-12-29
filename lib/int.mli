module Flags : sig
  (** The Flags module contains types to modify how binary integers are
      printed. *)

  type padding = Left | Right | Zeros
  type zero_printing = OCaml | InheritNonZero
  type flags = {
    padding : padding;
    separators : bool;
    prefix_non_zero : bool;
    zero_printing : zero_printing;
  }
  val default : flags
end

val pp_binary_int :
  flags:Flags.flags -> min_width:int -> Format.formatter -> int -> unit
(** [pp_binary_int ~flags ~min_width fmt n] prints the integer $n$ *)

val pp_int : Format.formatter -> int -> unit

val to_string_with : flags:Flags.flags -> min_width:int -> int -> string

val to_string : int -> string
