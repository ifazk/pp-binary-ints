(** This module provides functions create your own binary-int-printers. *)

module type S = sig
  type t

  val zero : t
  val one : t
  val logand : t -> t -> t
  val equal : t -> t -> bool
  val shift_right_logical : t -> int -> t
end

module type D = sig
  val prefix : string
  val suffix : string
end

module Make (I : S) (Dec : D) = struct
  type t = I.t
  include (Internal.Make (I) (Dec))
end
