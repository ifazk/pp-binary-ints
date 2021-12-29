module Flags : sig
  (** The Flags module contains types to modify how binary integers are
      printed. *)

  type padding = Left | Right | Zeros
  (** [padding] controls whether spaces are are added on the left or right or if
      zero prefixes are added. *)

  type zero_printing = OCaml | InheritNonZero
  (** [zero_printing] controls whether zeros printed similar to how [Printf]
      prints zeros or if zeros are printed similar to non-zero integers. *)

  type flags = {
    padding : padding;
    separators : bool;
    prefix_non_zero : bool;
    zero_printing : zero_printing;
  }
  (** [flags] are passed to pretty printing functions to customize the
      output. *)

  val default : flags
  (** A default set of flags. *)
end

val pp_binary_int :
  flags:Flags.flags -> min_width:int -> Format.formatter -> int -> unit
(** [pp_binary_int ~flags ~min_width fmt n] prints the integer [n] on the
    formatter [fmt], customizing the output with [~flags]. [~min_width] pads the
    output with enough spaces or zeros so that the output is at least
    [~min_width] characters, depends on [flags.padding]. *)

val pp_int : Format.formatter -> int -> unit
(** [pp_binary_int ~flags ~min_width fmt n] prints the integer [n] on the formatter [fmt]. *)

val to_string_with : flags:Flags.flags -> min_width:int -> int -> string
(** [to_string_width ~flags ~min_width n] converts the integer [n] to a binary
    integer [n]. customizing the output with [~flags]. [~min_width] pads the
    output with enough spaces or zeros so that the output is at least
    [~min_width] characters, depends on [flags.padding]. *)

val to_string : int -> string
(** [to_string n] converts the integer [n] to a binary integer [n]. *)
