(** This module provides functions create your own binary-int-printers. *)

module type S = sig
  (** Operations on integers usid in pretty printing. *)

  type t
  val zero : t
  val one : t
  val logand : t -> t -> t
  val equal : t -> t -> bool
  val shift_right_logical : t -> int -> t
end

module type D = sig
  (** Module type for prefixes and suffixes. *)

  val prefix : string
  val suffix : string
end

module Make (I : S) (Dec : D) : sig
  type t = I.t

  val pp_binary_int : flags:Flags.flags -> min_width:int -> Format.formatter -> I.t -> unit
  (** [pp_binary_int ~flags ~min_width fmt n] prints the integer [n] on the
      formatter [fmt], customizing the output with [~flags]. [~min_width] pads
      the output with enough spaces or zeros so that the output is at least
      [~min_width] characters, depends on [flags.padding]. *)

  val pp_int : Format.formatter -> I.t -> unit
  (** [pp_binary_int ~flags ~min_width fmt n] prints the integer [n] on the formatter [fmt]. *)

  val make_pp_int : ?flags:Flags.flags -> ?min_width:int -> unit -> Format.formatter -> I.t -> unit
  (** [make_pp_int ?flags ?min_width ()] is just [pp_binary_int ~flags
      ~min_width], but [flags] and [min_width] are optional. If omitted default
      values of [Flags.default] and [1] are passed to pp_binary_int. This
      version is nicer to with with the [Format] or [Fmt] modules. *)

  val to_string_with : flags:Flags.flags -> min_width:int -> I.t -> string
  (** [to_string_width ~flags ~min_width n] converts the integer [n] to a binary
      integer [n]. customizing the output with [~flags]. [~min_width] pads the
      output with enough spaces or zeros so that the output is at least
      [~min_width] characters, depends on [flags.padding]. *)

  val to_string : I.t -> string
  (** [to_string n] converts the integer [n] to a binary integer [n]. *)

  val make_to_string : ?flags:Flags.flags -> ?min_width:int -> unit -> I.t -> string
  (** [make_to_string ?flags ?min_width ()] is just [to_string_with ~flags
      ~min_width], but [flags] and [min_width] are optional. If omitted default
      values of [Flags.default] and [1] are passed to to_string_with. *)
end
