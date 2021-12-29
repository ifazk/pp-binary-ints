module Int = Stdlib.Int

module Flags = struct
  type padding =
    | Left
    | Right (* default *)
    | Zeros

  type zero_printing =
    | OCaml (* depends on padding setting: bunch of zeros (no separators, no prefixs), or space padding on the left or right *)
    | InheritNonZero

  type flags =
    { padding: padding
    ; separators: bool
    ; prefix_non_zero: bool
    ; zero_printing: zero_printing
    }

  let default =
    { padding = Right
    ; separators =  false
    ; prefix_non_zero =  false
    ; zero_printing = OCaml
    }
end

(* Underscore printing is tricky.
   Underscores and prefixes both count towards min width.
   Min width 5, no prefix, zero padding.
   Ob1111 should be printed as 01111, not _1111
   Min width 6, prefix.
   Ob1111 should be printed as 0b1111.
   Min width 5, with prefix.
   0b111 should be printed as 0b111.
 *)

(* Utilities *)
let nat_pred n =
  if (n > 0) then
    n - 1
  else
    0

let drop_next_bit rev_bits =
  rev_bits lsr 1

let get_next_bit_char rev_bits =
  if Int.equal 0 (Int.logand 1 rev_bits) then
    '0'
  else
    '1'

(* The next few functions assume zero padding.
   For space padding, 1 will be passed as the min_width
   If prefix is set to false, then 0 will be passed as the prefix_size.
*)
let not_at_end ~(min_width:int) ~prefix_size rev_bits =
  ((rev_bits <> 0) || (min_width > prefix_size))

let last_padding ~min_width ~prefix_size rev_bits =
  let open Int in
  equal rev_bits 0 &&
  equal min_width (prefix_size + 1)

let print_underscore ~min_width ~count ~separators ~prefix_size rev_bits =
  let open Int in
  separators &&
  (equal 0 ((count + 1) mod 5)) &&
  (not_at_end ~min_width ~prefix_size rev_bits) &&
  (not (last_padding ~min_width ~prefix_size rev_bits))

let rec push_chars ~buf ~separators ~prefix_size ~min_width ~count rev_bits : unit =
  if print_underscore ~min_width ~count ~separators ~prefix_size rev_bits then
    ( Buffer.add_char buf '_'
    ; push_chars ~buf ~separators ~prefix_size ~min_width:(nat_pred min_width) ~count:(count + 1) rev_bits
    )
  else if (not_at_end ~min_width ~prefix_size rev_bits) then
    ( Buffer.add_char buf (get_next_bit_char rev_bits)
    ; let rev_bits = drop_next_bit rev_bits in
      let min_width = nat_pred min_width in
      let count = count + 1 in
      push_chars ~buf ~separators ~prefix_size
        ~min_width
        ~count
        rev_bits
    )
  else
    ()

let rev_buffer ~separators ~prefix ~min_width n : Buffer.t =
  let buf = Buffer.create 16 in (* TODO: consider min_width for initial size *)
  let prefix_size = (if prefix then 2 else 0) in
  ( push_chars ~buf ~separators ~prefix_size ~min_width ~count:0 n
  ; if prefix then
      begin
        Buffer.add_char buf 'b';
        Buffer.add_char buf '0';
      end
  ; buf
  )

(* end of assuming zero padding *)

let pp_spaces fmt n =
  for _ = 1 to n do
    Format.pp_print_char fmt ' ';
  done

let pp_rev_buffer fmt buf =
  let len = Buffer.length buf in
  for i = 1 to len do
    Format.pp_print_char fmt (Buffer.nth buf (len - i))
  done

let pp_binary_int ~flags ~min_width fmt n =
  let open Flags in
  let min_width = max 1 min_width in
  let {padding; prefix_non_zero; separators; zero_printing} = flags in
  let buf =
    match padding with
    | Left | Right ->
      let prefix = prefix_non_zero && ((not (Int.equal 0 n)) || (zero_printing = InheritNonZero)) in
      let min_width = if prefix then 3 else 1 in
      rev_buffer
        ~separators
        ~prefix
        ~min_width
        n
    | Zeros ->
      if (zero_printing = OCaml) && Int.equal n 0 then
        rev_buffer ~separators:false ~prefix:false ~min_width 0
      else
        let prefix = prefix_non_zero in
        let min_width = max min_width (if prefix then 3 else 1) in
        rev_buffer ~separators ~prefix ~min_width n
  in
  let len = Buffer.length buf in
  match padding with
  | Left ->
    begin
      pp_spaces fmt (min_width - len);
      pp_rev_buffer fmt buf;
    end
  | Right ->
    begin
      pp_rev_buffer fmt buf;
      pp_spaces fmt (min_width - len);
    end
  | Zeros ->
      pp_rev_buffer fmt buf

let pp_int fmt n =
  pp_binary_int ~flags:(Flags.default) ~min_width:1 fmt n

let to_string n : string =
  Format.asprintf "%a" pp_int n

let to_string_with ~flags ~min_width : int -> string =
  Format.asprintf "%a" (pp_binary_int ~flags ~min_width)
