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
(** [flags] are passed to pretty printing functions to customize the output. *)

val default : flags
(** A default set of flags. *)
