open Pp_binary_ints.Nativeint

open Pp_binary_ints.Flags

let configs =
  [ { default with separators = false; prefix_non_zero = false }
  ; { default with separators = false; prefix_non_zero = true }
  ; { default with separators = true; prefix_non_zero = false }
  ; { default with separators = true; prefix_non_zero = true }
  ]

let zero_inherit_configs =
  List.map (fun x -> { x with padding = Zeros; zero_printing = InheritNonZero }) configs

let left_inherit_configs =
  List.map (fun x -> { x with padding = Left; zero_printing = InheritNonZero }) configs

let right_inherit_configs =
  List.map (fun x -> { x with padding = Right; zero_printing = InheritNonZero }) configs

let test_width configs min_width n : string list =
  List.map (fun flags -> to_string_with ~flags ~min_width n) configs

(** * Five printing *)

let%test "one default" [@tags "64-bits-only"] =
  "0b101n" =
  to_string 0b101n

let%test "one default manual" [@tags "64-bits-only"] =
  "0b101n" =
  to_string_with ~flags:default ~min_width:1 0b101n

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" [@tags "64-bits-only"] =
  ["101n";"0b101n";"101n";"0b101n"] =
  test_width zero_inherit_configs 1 0b101n

let%test "zero inherit 2" [@tags "64-bits-only"] =
  ["101n";"0b101n";"101n";"0b101n"] =
  test_width zero_inherit_configs 2 0b101n

let%test "zero inherit 3" [@tags "64-bits-only"] =
  ["101n";"0b101n";"101n";"0b101n"] =
  test_width zero_inherit_configs 3 0b101n

let%test "zero inherit 4" [@tags "64-bits-only"] =
  ["101n";"0b101n";"101n";"0b101n"] =
  test_width zero_inherit_configs 4 0b101n

let%test "zero inherit 5" [@tags "64-bits-only"] =
  ["0101n"
  ;"0b101n"
  ;"0101n"
  ;"0b101n"
  ] =
  test_width zero_inherit_configs 5 0b101n

let%test "zero inherit 6" [@tags "64-bits-only"] =
  ["00101n"
  ;"0b101n"
  ;"00101n"
  ;"0b101n"
  ] =
  test_width zero_inherit_configs 6 0b101n

let%test "zero inherit 7" [@tags "64-bits-only"] =
  ["000101n"
  ;"0b0101n"
  ;"0_0101n"
  ;"0b0101n"] =
  test_width zero_inherit_configs 7 0b101n

let%test "zero inherit 8" [@tags "64-bits-only"] =
  ["0000101n"
  ;"0b00101n"
  ;"00_0101n"
  ;"0b00101n"] =
  test_width zero_inherit_configs 8 0b101n

let%test "zero inherit 9" [@tags "64-bits-only"] =
  ["00000101n"
  ;"0b000101n"
  ;"000_0101n"
  ;"0b0_0101n"] =
  test_width zero_inherit_configs 9 0b101n

(** ** Left Padding, Inherit *)

let%test "left inherit 1" [@tags "64-bits-only"] =
  ["101n";"0b101n";"101n";"0b101n"] =
  test_width left_inherit_configs 1 0b101n

let%test "left inherit 2" [@tags "64-bits-only"] =
  ["101n";"0b101n";"101n";"0b101n"] =
  test_width left_inherit_configs 2 0b101n

let%test "left inherit 3" [@tags "64-bits-only"] =
  ["101n";"0b101n";"101n";"0b101n"] =
  test_width left_inherit_configs 3 0b101n

let%test "left inherit 4" [@tags "64-bits-only"] =
  ["101n";"0b101n";"101n";"0b101n"] =
  test_width left_inherit_configs 4 0b101n

let%test "left inherit 5" [@tags "64-bits-only"] =
  [" 101n";"0b101n";" 101n";"0b101n"] =
  test_width left_inherit_configs 5 0b101n

let%test "left inherit 6" [@tags "64-bits-only"] =
  ["  101n";"0b101n";"  101n";"0b101n"] =
  test_width left_inherit_configs 6 0b101n

let%test "left inherit 7" [@tags "64-bits-only"] =
  ["   101n";" 0b101n";"   101n";" 0b101n"] =
  test_width left_inherit_configs 7 0b101n

(** ** Right Padding, Inherit *)

let%test "right inherit 1" [@tags "64-bits-only"] =
  ["101n";"0b101n";"101n";"0b101n"] =
  test_width right_inherit_configs 1 0b101n

let%test "right inherit 2" [@tags "64-bits-only"] =
  ["101n";"0b101n";"101n";"0b101n"] =
  test_width right_inherit_configs 2 0b101n

let%test "right inherit 3" [@tags "64-bits-only"] =
  ["101n";"0b101n";"101n";"0b101n"] =
  test_width right_inherit_configs 3 0b101n

let%test "right inherit 4" [@tags "64-bits-only"] =
  ["101n";"0b101n";"101n";"0b101n"] =
  test_width right_inherit_configs 4 0b101n

let%test "right inherit 5" [@tags "64-bits-only"] =
  ["101n ";"0b101n";"101n ";"0b101n"] =
  test_width right_inherit_configs 5 0b101n

let%test "right inherit 6" [@tags "64-bits-only"] =
  ["101n  ";"0b101n";"101n  ";"0b101n"] =
  test_width right_inherit_configs 6 0b101n

let%test "right inherit 7" [@tags "64-bits-only"] =
  ["101n   ";"0b101n ";"101n   ";"0b101n "] =
  test_width right_inherit_configs 7 0b101n

(** * Eight printing *)

let%test "one default" [@tags "64-bits-only"] =
  "0b1000n" =
  to_string 0b1000n

let%test "one default manual" [@tags "64-bits-only"] =
  "0b1000n" =
  to_string_with ~flags:default ~min_width:1 0b1000n

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width zero_inherit_configs 1 0b1000n

let%test "zero inherit 2" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width zero_inherit_configs 2 0b1000n

let%test "zero inherit 3" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width zero_inherit_configs 3 0b1000n

let%test "zero inherit 4" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width zero_inherit_configs 4 0b1000n

let%test "zero inherit 5" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width zero_inherit_configs 5 0b1000n

let%test "zero inherit 6" [@tags "64-bits-only"] =
  ["01000n";"0b1000n";"01000n";"0b1000n"] =
  test_width zero_inherit_configs 6 0b1000n

let%test "zero inherit 7" [@tags "64-bits-only"] =
  ["001000n";"0b1000n";"0_1000n";"0b1000n"] =
  test_width zero_inherit_configs 7 0b1000n

let%test "zero inherit 8" [@tags "64-bits-only"] =
  ["0001000n";"0b01000n";"00_1000n";"0b01000n"] =
  test_width zero_inherit_configs 8 0b1000n

let%test "zero inherit 9" [@tags "64-bits-only"] =
  ["00001000n";"0b001000n";"000_1000n";"0b0_1000n"] =
  test_width zero_inherit_configs 9 0b1000n

(** ** Left Padding, Inherit *)

let%test "left inherit 1" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width left_inherit_configs 1 0b1000n

let%test "left inherit 2" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width left_inherit_configs 2 0b1000n

let%test "left inherit 3" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width left_inherit_configs 3 0b1000n

let%test "left inherit 4" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width left_inherit_configs 4 0b1000n

let%test "left inherit 5" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width left_inherit_configs 5 0b1000n

let%test "left inherit 6" [@tags "64-bits-only"] =
  [" 1000n";"0b1000n";" 1000n";"0b1000n"] =
  test_width left_inherit_configs 6 0b1000n

let%test "left inherit 7" [@tags "64-bits-only"] =
  ["  1000n";"0b1000n";"  1000n";"0b1000n"] =
  test_width left_inherit_configs 7 0b1000n

let%test "left inherit 8" [@tags "64-bits-only"] =
  ["   1000n";" 0b1000n";"   1000n";" 0b1000n"] =
  test_width left_inherit_configs 8 0b1000n

(** ** Right Padding, Inherit *)

let%test "right inherit 1" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width right_inherit_configs 1 0b1000n

let%test "right inherit 2" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width right_inherit_configs 2 0b1000n

let%test "right inherit 3" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width right_inherit_configs 3 0b1000n

let%test "right inherit 4" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width right_inherit_configs 4 0b1000n

let%test "right inherit 5" [@tags "64-bits-only"] =
  ["1000n";"0b1000n";"1000n";"0b1000n"] =
  test_width right_inherit_configs 5 0b1000n

let%test "right inherit 6" [@tags "64-bits-only"] =
  ["1000n ";"0b1000n";"1000n ";"0b1000n"] =
  test_width right_inherit_configs 6 0b1000n

let%test "right inherit 7" [@tags "64-bits-only"] =
  ["1000n  ";"0b1000n";"1000n  ";"0b1000n"] =
  test_width right_inherit_configs 7 0b1000n

let%test "right inherit 8" [@tags "64-bits-only"] =
  ["1000n   ";"0b1000n ";"1000n   ";"0b1000n "] =
  test_width right_inherit_configs 8 0b1000n

(** * Seventeen printing *)

let%test "one default" [@tags "64-bits-only"] =
  "0b1_0001n" =
  to_string 0b10001n

let%test "one default manual" [@tags "64-bits-only"] =
  "0b1_0001n" =
  to_string_with ~flags:default ~min_width:1 0b10001n

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width zero_inherit_configs 1 0b10001n

let%test "zero inherit 2" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width zero_inherit_configs 2 0b10001n

let%test "zero inherit 3" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width zero_inherit_configs 3 0b10001n

let%test "zero inherit 4" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width zero_inherit_configs 4 0b10001n

let%test "zero inherit 5" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width zero_inherit_configs 5 0b10001n

let%test "zero inherit 6" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width zero_inherit_configs 6 0b10001n

let%test "zero inherit 7" [@tags "64-bits-only"] =
  ["010001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width zero_inherit_configs 7 0b10001n

let%test "zero inherit 8" [@tags "64-bits-only"] =
  ["0010001n";"0b10001n";"01_0001n";"0b1_0001n"] =
  test_width zero_inherit_configs 8 0b10001n

let%test "zero inherit 9" [@tags "64-bits-only"] =
  ["00010001n";"0b010001n";"001_0001n";"0b1_0001n"] =
  test_width zero_inherit_configs 9 0b10001n

let%test "zero inherit 10" [@tags "64-bits-only"] =
  ["000010001n"
  ;"0b0010001n"
  ;"0001_0001n"
  ;"0b01_0001n"] =
  test_width zero_inherit_configs 10 0b10001n

(** ** Left Padding, Inherit *)

let%test "left inherit 1" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width left_inherit_configs 1 0b10001n

let%test "left inherit 2" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width left_inherit_configs 2 0b10001n

let%test "left inherit 3" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width left_inherit_configs 3 0b10001n

let%test "left inherit 4" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width left_inherit_configs 4 0b10001n

let%test "left inherit 5" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width left_inherit_configs 5 0b10001n

let%test "left inherit 6" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width left_inherit_configs 6 0b10001n

let%test "left inherit 7" [@tags "64-bits-only"] =
  [" 10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width left_inherit_configs 7 0b10001n

let%test "left inherit 8" [@tags "64-bits-only"] =
  ["  10001n";"0b10001n";" 1_0001n";"0b1_0001n"] =
  test_width left_inherit_configs 8 0b10001n

let%test "left inherit 9" [@tags "64-bits-only"] =
  ["   10001n";" 0b10001n";"  1_0001n";"0b1_0001n"] =
  test_width left_inherit_configs 9 0b10001n

let%test "left inherit 10" [@tags "64-bits-only"] =
  ["    10001n";"  0b10001n";"   1_0001n";" 0b1_0001n"] =
  test_width left_inherit_configs 10 0b10001n

(** ** Right Padding, Inherit *)

let%test "right inherit 1" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width right_inherit_configs 1 0b10001n

let%test "right inherit 2" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width right_inherit_configs 2 0b10001n

let%test "right inherit 3" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width right_inherit_configs 3 0b10001n

let%test "right inherit 4" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width right_inherit_configs 4 0b10001n

let%test "right inherit 5" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width right_inherit_configs 5 0b10001n

let%test "right inherit 6" [@tags "64-bits-only"] =
  ["10001n";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width right_inherit_configs 6 0b10001n

let%test "right inherit 7" [@tags "64-bits-only"] =
  ["10001n ";"0b10001n";"1_0001n";"0b1_0001n"] =
  test_width right_inherit_configs 7 0b10001n

let%test "right inherit 8" [@tags "64-bits-only"] =
  ["10001n  ";"0b10001n";"1_0001n ";"0b1_0001n"] =
  test_width right_inherit_configs 8 0b10001n

let%test "right inherit 9" [@tags "64-bits-only"] =
  ["10001n   ";"0b10001n ";"1_0001n  ";"0b1_0001n"] =
  test_width right_inherit_configs 9 0b10001n

let%test "right inherit 10" [@tags "64-bits-only"] =
  ["10001n    ";"0b10001n  ";"1_0001n   ";"0b1_0001n "] =
  test_width right_inherit_configs 10 0b10001n

(** * Large printing *)

let%test "zero inherit 17" [@tags "64-bits-only"] =
  ["0000000000110111n";"0b00000000110111n";"0_0000_0011_0111n";"0b0000_0011_0111n"] =
  test_width zero_inherit_configs 17 0b110111n

let%test "left inherit 17" [@tags "64-bits-only"] =
  ["          110111n";"        0b110111n";"         11_0111n";"       0b11_0111n"] =
  test_width left_inherit_configs 17 0b110111n

let%test "right inherit 16" [@tags "64-bits-only"] =
  ["110111n          ";"0b110111n        ";"11_0111n         ";"0b11_0111n       "] =
  test_width right_inherit_configs 17 0b110111n

(** * -1 printing *)

let%test "zero inherit -1 1" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width zero_inherit_configs 1 (-1n)

let%test "left inherit -1 1" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width left_inherit_configs 1 (-1n)

let%test "right inherit -1 1" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width right_inherit_configs 1 (-1n)

let%test "zero inherit -1 65" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width zero_inherit_configs 65 (-1n)

let%test "left inherit -1 65" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width left_inherit_configs 65 (-1n)

let%test "right inherit -1 65" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width right_inherit_configs 65 (-1n)

let%test "zero inherit -1 66" [@tags "64-bits-only"] =
  ["01111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width zero_inherit_configs 66 (-1n)

let%test "left inherit -1 66" [@tags "64-bits-only"] =
  [" 1111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width left_inherit_configs 66 (-1n)

let%test "right inherit -1 66" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width right_inherit_configs 66 (-1n)

let%test "zero inherit -1 67" [@tags "64-bits-only"] =
  ["001111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width zero_inherit_configs 67 (-1n)

let%test "left inherit -1 67" [@tags "64-bits-only"] =
  ["  1111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width left_inherit_configs 67 (-1n)

let%test "right inherit -1 67" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n  "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width right_inherit_configs 67 (-1n)

let%test "zero inherit -1 68" [@tags "64-bits-only"] =
  ["0001111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b01111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width zero_inherit_configs 68 (-1n)

let%test "left inherit -1 68" [@tags "64-bits-only"] =
  ["   1111111111111111111111111111111111111111111111111111111111111111n"
  ;" 0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width left_inherit_configs 68 (-1n)

let%test "right inherit -1 68" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n   "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n "
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width right_inherit_configs 68 (-1n)

let%test "zero inherit -1 79" [@tags "64-bits-only"] =
  ["000000000000001111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b0000000000001111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width zero_inherit_configs 79 (-1n)

let%test "left inherit -1 79" [@tags "64-bits-only"] =
  ["              1111111111111111111111111111111111111111111111111111111111111111n"
  ;"            0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width left_inherit_configs 79 (-1n)

let%test "right inherit -1 79" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n              "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n            "
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width right_inherit_configs 79 (-1n)

let%test "zero inherit -1 80" [@tags "64-bits-only"] =
  ["0000000000000001111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b00000000000001111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width zero_inherit_configs 80 (-1n)

let%test "left inherit -1 80" [@tags "64-bits-only"] =
  ["               1111111111111111111111111111111111111111111111111111111111111111n"
  ;"             0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width left_inherit_configs 80 (-1n)

let%test "right inherit -1 80" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n               "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n             "
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width right_inherit_configs 80 (-1n)

let%test "zero inherit -1 81" [@tags "64-bits-only"] =
  ["00000000000000001111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b000000000000001111111111111111111111111111111111111111111111111111111111111111n"
  ;"01111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width zero_inherit_configs 81 (-1n)

let%test "left inherit -1 81" [@tags "64-bits-only"] =
  ["                1111111111111111111111111111111111111111111111111111111111111111n"
  ;"              0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;" 1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width left_inherit_configs 81 (-1n)

let%test "right inherit -1 81" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n                "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n              "
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n "
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width right_inherit_configs 81 (-1n)

let%test "zero inherit -1 82" [@tags "64-bits-only"] =
  ["000000000000000001111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b0000000000000001111111111111111111111111111111111111111111111111111111111111111n"
  ;"0_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width zero_inherit_configs 82 (-1n)

let%test "left inherit -1 82" [@tags "64-bits-only"] =
  ["                 1111111111111111111111111111111111111111111111111111111111111111n"
  ;"               0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"  1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width left_inherit_configs 82 (-1n)

let%test "right inherit -1 82" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n                 "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n               "
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n  "
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width right_inherit_configs 82 (-1n)

let%test "zero inherit -1 83" [@tags "64-bits-only"] =
  ["0000000000000000001111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b00000000000000001111111111111111111111111111111111111111111111111111111111111111n"
  ;"00_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b01111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width zero_inherit_configs 83 (-1n)

let%test "left inherit -1 83" [@tags "64-bits-only"] =
  ["                  1111111111111111111111111111111111111111111111111111111111111111n"
  ;"                0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"   1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;" 0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width left_inherit_configs 83 (-1n)

let%test "right inherit -1 83" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n                  "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n                "
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n   "
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n "
  ] =
  test_width right_inherit_configs 83 (-1n)

let%test "zero inherit -1 84" [@tags "64-bits-only"] =
  ["00000000000000000001111111111111111111111111111111111111111111111111111111111111111n"
  ;"0b000000000000000001111111111111111111111111111111111111111111111111111111111111111n"
  ;"000_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"0b0_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width zero_inherit_configs 84 (-1n)

let%test "left inherit -1 84" [@tags "64-bits-only"] =
  ["                   1111111111111111111111111111111111111111111111111111111111111111n"
  ;"                 0b1111111111111111111111111111111111111111111111111111111111111111n"
  ;"    1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ;"  0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n"
  ] =
  test_width left_inherit_configs 84 (-1n)

let%test "right inherit -1 84" [@tags "64-bits-only"] =
  ["1111111111111111111111111111111111111111111111111111111111111111n                   "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111n                 "
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n    "
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111n  "
  ] =
  test_width right_inherit_configs 84 (-1n)
