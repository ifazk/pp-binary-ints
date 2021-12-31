(** This module is interal to pp-binary-ints and is subject to change without
    notice. *)

module IntUtils = struct
  let nat_pred n =
    if (n > 0) then
      n - 1
    else
      0

  let nat_minus n m =
    let sub = n - m in
    if (sub > 0) then
      sub
    else
      0
end

module PPUtils = struct

  let pp_spaces fmt n =
    for _ = 1 to n do
      Format.pp_print_char fmt ' ';
    done

  let pp_rev_buffer fmt buf =
    let len = Buffer.length buf in
    for i = 1 to len do
      Format.pp_print_char fmt (Buffer.nth buf (len - i))
    done

end

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

module MakeDecorators (Dec : D) = struct
  include Dec
  let prefix_size = String.length prefix
  let suffix_size = String.length suffix

  let push_rev_prefix buf =
    for i = 1 to prefix_size do
      Buffer.add_char buf (String.get prefix (prefix_size - i))
    done

  let push_rev_suffix buf =
    for i = 1 to suffix_size do
      Buffer.add_char buf (String.get suffix (suffix_size - i))
    done
end

module Make (I : S) (Dec : D) = struct
(* Underscore printing is tricky.
   Underscores and prefixes both count towards min width.
   Min width 5, no prefix, zero padding.
   Ob1111 should be printed as 01111, not _1111
   Min width 6, prefix.
   Ob1111 should be printed as 0b1111.
   Min width 5, with prefix.
   0b111 should be printed as 0b111.
 *)

  module Decorators = MakeDecorators (Dec)

  (* Utilities *)
  let drop_next_bit rev_bits =
    I.shift_right_logical rev_bits 1

  let get_next_bit_char rev_bits =
    if I.equal I.zero (I.logand I.one rev_bits) then
      '0'
    else
      '1'

  (* The next few functions assume zero padding.
     For space padding, 1 will be passed as the min_width
     If prefix is set to false, then 0 will be passed as the prefix_size.
  *)
  let not_at_end ~(min_width:int) ~prefix_size rev_bits =
    ((rev_bits <> I.zero) || (min_width > prefix_size))

  let last_padding ~min_width ~prefix_size rev_bits =
    let open I in
    equal rev_bits zero &&
    (prefix_size + 1) = min_width

  let print_underscore ~min_width ~count ~separators ~prefix_size rev_bits =
    separators &&
    (0 = ((count + 1) mod 5)) &&
    (not_at_end ~min_width ~prefix_size rev_bits) &&
    (not (last_padding ~min_width ~prefix_size rev_bits))

  let rec push_chars ~buf ~separators ~prefix_size ~min_width ~count rev_bits : unit =
    if print_underscore ~min_width ~count ~separators ~prefix_size rev_bits then
      ( Buffer.add_char buf '_'
      ; push_chars ~buf ~separators ~prefix_size ~min_width:(IntUtils.nat_pred min_width) ~count:(count + 1) rev_bits
      )
    else if (not_at_end ~min_width ~prefix_size rev_bits) then
      ( Buffer.add_char buf (get_next_bit_char rev_bits)
      ; let rev_bits = drop_next_bit rev_bits in
        let min_width = IntUtils.nat_pred min_width in
        let count = count + 1 in
        push_chars ~buf ~separators ~prefix_size
          ~min_width
          ~count
          rev_bits
      )
    else
      ()

  let push_bit_chars ~buf ~separators ~prefix_size ~min_width rev_bits : unit =
    let min_width = max (1 + prefix_size) min_width in
    push_chars ~buf ~separators ~prefix_size ~min_width ~count:0 rev_bits

  let rev_buffer ~separators ~prefix ~min_width n : Buffer.t =
    let buf = Buffer.create 16 in (* TODO: consider min_width for initial size *)
    let prefix_size = (if prefix then Decorators.prefix_size else 0) in
    ( Decorators.push_rev_suffix buf
    ; push_bit_chars ~buf ~separators ~prefix_size ~min_width:(IntUtils.nat_minus min_width Decorators.suffix_size) n
    ; if prefix then
        Decorators.push_rev_prefix buf
    ; buf
    )

  (* end of assuming zero padding *)


  let pp_binary_int ~flags ~min_width fmt n =
    let open Flags in
    let min_width = max 1 min_width in
    let {padding; prefix_non_zero; separators; zero_printing} = flags in
    let buf =
      match padding with
      | Left | Right ->
        let prefix = prefix_non_zero && ((not (I.equal I.zero n)) || (zero_printing = InheritNonZero)) in
        let min_width = 1 in
        rev_buffer
          ~separators
          ~prefix
          ~min_width
          n
      | Zeros ->
        if (zero_printing = OCaml) && I.equal n I.zero then
          rev_buffer ~separators ~prefix:false ~min_width I.zero
        else
          let prefix = prefix_non_zero in
          let min_width = max min_width (if prefix then 3 else 1) in
          rev_buffer ~separators ~prefix ~min_width n
    in
    let len = Buffer.length buf in
    match padding with
    | Left ->
      begin
        PPUtils.pp_spaces fmt (min_width - len);
        PPUtils.pp_rev_buffer fmt buf;
      end
    | Right ->
      begin
        PPUtils.pp_rev_buffer fmt buf;
        PPUtils.pp_spaces fmt (min_width - len);
      end
    | Zeros ->
      PPUtils.pp_rev_buffer fmt buf


  let make_pp_int ?(flags=Flags.default) ?(min_width=1) () =
    pp_binary_int ~flags ~min_width

  let pp_int fmt n =
    pp_binary_int ~flags:(Flags.default) ~min_width:1 fmt n

  let to_string n : string =
    Format.asprintf "%a" pp_int n

  let to_string_with ~flags ~min_width : I.t -> string =
    Format.asprintf "%a" (pp_binary_int ~flags ~min_width)

  let make_to_string ?(flags=Flags.default) ?(min_width=1) () =
    to_string_with ~flags ~min_width
end
