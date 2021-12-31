type t = int64

val pp_binary_int :
  flags:Flags.flags -> min_width:int -> Format.formatter -> int64 -> unit
(** [pp_binary_int ~flags ~min_width fmt n] prints the integer [n] on the
    formatter [fmt], customizing the output with [~flags]. [~min_width] pads the
    output with enough spaces or zeros so that the output is at least
    [~min_width] characters, depends on [flags.padding]. *)

val pp_int : Format.formatter -> int64 -> unit
(** [pp_binary_int ~flags ~min_width fmt n] prints the integer [n] on the formatter [fmt]. *)

val make_pp_int :
  ?flags:Flags.flags -> ?min_width:int -> unit -> Format.formatter -> int64 -> unit
(** [make_pp_int ?flags ?min_width ()] is just [pp_binary_int ~flags
    ~min_width], but [flags] and [min_width] are optional. If omitted default
    values of [Flags.default] and [1] are passed to pp_binary_int. This version
    is nicer to with with the [Format] or [Fmt] modules. *)

val to_string_with : flags:Flags.flags -> min_width:int -> int64 -> string
(** [to_string_width ~flags ~min_width n] converts the integer [n] to a binary
    integer [n]. customizing the output with [~flags]. [~min_width] pads the
    output with enough spaces or zeros so that the output is at least
    [~min_width] characters, depends on [flags.padding]. *)

val to_string : int64 -> string
(** [to_string n] converts the integer [n] to a binary integer [n]. *)

val make_to_string :
  ?flags:Flags.flags -> ?min_width:int -> unit -> int64 -> string
(** [make_to_string ?flags ?min_width ()] is just [to_string_with ~flags
    ~min_width], but [flags] and [min_width] are optional. If omitted default
    values of [Flags.default] and [1] are passed to to_string_with. *)
