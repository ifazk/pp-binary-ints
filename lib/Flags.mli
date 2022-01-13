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
  suffix : bool;
  zero_printing : zero_printing;
}
(** [flags] are passed to pretty printing functions to customize the output. *)

val default : flags
(** A default set of flags. *)

val make_flags : ?zero_padding:bool -> ?left_padding:bool -> ?separators:bool -> ?prefix:bool -> ?suffix:bool -> ?zero_special:bool -> unit -> flags
(** A function for creating flags. The [left_padding] prameter is ignored if
    [zero_padding] is set to [true]. The default values are as follows.
{ul {- [zero_padding=true]}
    {- [left_padding=false]}
    {- [separators=true]}
    {- [prefix=true]}
    {- [suffix=true]}
    {- [zero_special=false]}
}
*)
