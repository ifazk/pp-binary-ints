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

  val pp_int : Format.formatter -> I.t -> unit
  (** [pp_binary_int ~flags ~min_width fmt n] prints the integer [n] on the
      formatter [fmt]. *)

  val make_pp_int : ?zero_padding:bool -> ?left_padding:bool -> ?separators:bool -> ?prefix:bool -> ?suffix:bool -> ?zero_special:bool -> ?min_width:int -> unit -> Format.formatter -> I.t -> unit
  (** [make_pp_int ?zero_padding ?left_padding ?separators ?prefix ?suffix
      ?zero_special ?min_width ?min_width ()] is just [pp__int_with
      ~flags:(Flags.make_flags ?zero_padding ?left_padding ?separators ?prefix
      ?suffix ?zero_special) ~min_width], but the prameters are optional. The
      default value of [min_width] is [1]. This version is nicer when using the
      [Format] or [Fmt] modules. *)

  val to_string : I.t -> string
  (** [to_string n] converts the integer [n] to a binary integer [n]. *)

  val make_to_string : ?zero_padding:bool -> ?left_padding:bool -> ?separators:bool -> ?prefix:bool -> ?suffix:bool -> ?zero_special:bool -> ?min_width:int -> unit -> I.t -> string
  (** [make_to_string ?zero_padding ?left_padding ?separators ?prefix ?suffix
      ?zero_special ?min_width ()] is just [to_string_with
      ~flags:(Flags.make_flags ?zero_padding ?left_padding ?separators ?prefix
      ?suffix ?zero_special) ~min_width], but the parameters are all optional.
      The default value of [min_width] is [1]. *)

  val pp_int_with : flags:Flags.flags -> min_width:int -> Format.formatter -> I.t -> unit
  (** [pp_int_with ~flags ~min_width fmt n] prints the integer [n] on the
      formatter [fmt], customizing the output with [~flags]. [~min_width] pads
      the output with enough spaces or zeros so that the output is at least
      [~min_width] characters, depends on [flags.padding]. This is a lower level
      version of [make_pp_int]. *)

  val to_string_with : flags:Flags.flags -> min_width:int -> I.t -> string
  (** [to_string_width ~flags ~min_width n] converts the integer [n] to a binary
      integer [n]. customizing the output with [~flags]. [~min_width] pads the
      output with enough spaces or zeros so that the output is at least
      [~min_width] characters, depends on [flags.padding]. This is a lower level
      version of [make_to_string]. *)
end
