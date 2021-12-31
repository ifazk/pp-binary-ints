open Pp_binary_ints.Int64

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

let%test "one default" =
  "101L" =
  to_string 0b101L

let%test "one default manual" =
  "101L" =
  to_string_with ~flags:default ~min_width:1 0b101L

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["101L";"0b101L";"101L";"0b101L"] =
  test_width zero_inherit_configs 1 0b101L

let%test "zero inherit 2" =
  ["101L";"0b101L";"101L";"0b101L"] =
  test_width zero_inherit_configs 2 0b101L

let%test "zero inherit 3" =
  ["101L";"0b101L";"101L";"0b101L"] =
  test_width zero_inherit_configs 3 0b101L

let%test "zero inherit 4" =
  ["101L";"0b101L";"101L";"0b101L"] =
  test_width zero_inherit_configs 4 0b101L

let%test "zero inherit 5" =
  ["0101L"
  ;"0b101L"
  ;"0101L"
  ;"0b101L"
  ] =
  test_width zero_inherit_configs 5 0b101L

let%test "zero inherit 6" =
  ["00101L"
  ;"0b101L"
  ;"00101L"
  ;"0b101L"
  ] =
  test_width zero_inherit_configs 6 0b101L

let%test "zero inherit 7" =
  ["000101L"
  ;"0b0101L"
  ;"0_0101L"
  ;"0b0101L"] =
  test_width zero_inherit_configs 7 0b101L

let%test "zero inherit 8" =
  ["0000101L"
  ;"0b00101L"
  ;"00_0101L"
  ;"0b00101L"] =
  test_width zero_inherit_configs 8 0b101L

let%test "zero inherit 9" =
  ["00000101L"
  ;"0b000101L"
  ;"000_0101L"
  ;"0b0_0101L"] =
  test_width zero_inherit_configs 9 0b101L

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["101L";"0b101L";"101L";"0b101L"] =
  test_width left_inherit_configs 1 0b101L

let%test "left inherit 2" =
  ["101L";"0b101L";"101L";"0b101L"] =
  test_width left_inherit_configs 2 0b101L

let%test "left inherit 3" =
  ["101L";"0b101L";"101L";"0b101L"] =
  test_width left_inherit_configs 3 0b101L

let%test "left inherit 4" =
  ["101L";"0b101L";"101L";"0b101L"] =
  test_width left_inherit_configs 4 0b101L

let%test "left inherit 5" =
  [" 101L";"0b101L";" 101L";"0b101L"] =
  test_width left_inherit_configs 5 0b101L

let%test "left inherit 6" =
  ["  101L";"0b101L";"  101L";"0b101L"] =
  test_width left_inherit_configs 6 0b101L

let%test "left inherit 7" =
  ["   101L";" 0b101L";"   101L";" 0b101L"] =
  test_width left_inherit_configs 7 0b101L

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["101L";"0b101L";"101L";"0b101L"] =
  test_width right_inherit_configs 1 0b101L

let%test "right inherit 2" =
  ["101L";"0b101L";"101L";"0b101L"] =
  test_width right_inherit_configs 2 0b101L

let%test "right inherit 3" =
  ["101L";"0b101L";"101L";"0b101L"] =
  test_width right_inherit_configs 3 0b101L

let%test "right inherit 4" =
  ["101L";"0b101L";"101L";"0b101L"] =
  test_width right_inherit_configs 4 0b101L

let%test "right inherit 5" =
  ["101L ";"0b101L";"101L ";"0b101L"] =
  test_width right_inherit_configs 5 0b101L

let%test "right inherit 6" =
  ["101L  ";"0b101L";"101L  ";"0b101L"] =
  test_width right_inherit_configs 6 0b101L

let%test "right inherit 7" =
  ["101L   ";"0b101L ";"101L   ";"0b101L "] =
  test_width right_inherit_configs 7 0b101L

(** * Eight printing *)

let%test "one default" =
  "1000L" =
  to_string 0b1000L

let%test "one default manual" =
  "1000L" =
  to_string_with ~flags:default ~min_width:1 0b1000L

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width zero_inherit_configs 1 0b1000L

let%test "zero inherit 2" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width zero_inherit_configs 2 0b1000L

let%test "zero inherit 3" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width zero_inherit_configs 3 0b1000L

let%test "zero inherit 4" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width zero_inherit_configs 4 0b1000L

let%test "zero inherit 5" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width zero_inherit_configs 5 0b1000L

let%test "zero inherit 6" =
  ["01000L";"0b1000L";"01000L";"0b1000L"] =
  test_width zero_inherit_configs 6 0b1000L

let%test "zero inherit 7" =
  ["001000L";"0b1000L";"0_1000L";"0b1000L"] =
  test_width zero_inherit_configs 7 0b1000L

let%test "zero inherit 8" =
  ["0001000L";"0b01000L";"00_1000L";"0b01000L"] =
  test_width zero_inherit_configs 8 0b1000L

let%test "zero inherit 9" =
  ["00001000L";"0b001000L";"000_1000L";"0b0_1000L"] =
  test_width zero_inherit_configs 9 0b1000L

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width left_inherit_configs 1 0b1000L

let%test "left inherit 2" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width left_inherit_configs 2 0b1000L

let%test "left inherit 3" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width left_inherit_configs 3 0b1000L

let%test "left inherit 4" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width left_inherit_configs 4 0b1000L

let%test "left inherit 5" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width left_inherit_configs 5 0b1000L

let%test "left inherit 6" =
  [" 1000L";"0b1000L";" 1000L";"0b1000L"] =
  test_width left_inherit_configs 6 0b1000L

let%test "left inherit 7" =
  ["  1000L";"0b1000L";"  1000L";"0b1000L"] =
  test_width left_inherit_configs 7 0b1000L

let%test "left inherit 8" =
  ["   1000L";" 0b1000L";"   1000L";" 0b1000L"] =
  test_width left_inherit_configs 8 0b1000L

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width right_inherit_configs 1 0b1000L

let%test "right inherit 2" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width right_inherit_configs 2 0b1000L

let%test "right inherit 3" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width right_inherit_configs 3 0b1000L

let%test "right inherit 4" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width right_inherit_configs 4 0b1000L

let%test "right inherit 5" =
  ["1000L";"0b1000L";"1000L";"0b1000L"] =
  test_width right_inherit_configs 5 0b1000L

let%test "right inherit 6" =
  ["1000L ";"0b1000L";"1000L ";"0b1000L"] =
  test_width right_inherit_configs 6 0b1000L

let%test "right inherit 7" =
  ["1000L  ";"0b1000L";"1000L  ";"0b1000L"] =
  test_width right_inherit_configs 7 0b1000L

let%test "right inherit 8" =
  ["1000L   ";"0b1000L ";"1000L   ";"0b1000L "] =
  test_width right_inherit_configs 8 0b1000L

(** * Seventeen printing *)

let%test "one default" =
  "10001L" =
  to_string 0b10001L

let%test "one default manual" =
  "10001L" =
  to_string_with ~flags:default ~min_width:1 0b10001L

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width zero_inherit_configs 1 0b10001L

let%test "zero inherit 2" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width zero_inherit_configs 2 0b10001L

let%test "zero inherit 3" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width zero_inherit_configs 3 0b10001L

let%test "zero inherit 4" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width zero_inherit_configs 4 0b10001L

let%test "zero inherit 5" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width zero_inherit_configs 5 0b10001L

let%test "zero inherit 6" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width zero_inherit_configs 6 0b10001L

let%test "zero inherit 7" =
  ["010001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width zero_inherit_configs 7 0b10001L

let%test "zero inherit 8" =
  ["0010001L";"0b10001L";"01_0001L";"0b1_0001L"] =
  test_width zero_inherit_configs 8 0b10001L

let%test "zero inherit 9" =
  ["00010001L";"0b010001L";"001_0001L";"0b1_0001L"] =
  test_width zero_inherit_configs 9 0b10001L

let%test "zero inherit 10" =
  ["000010001L"
  ;"0b0010001L"
  ;"0001_0001L"
  ;"0b01_0001L"] =
  test_width zero_inherit_configs 10 0b10001L

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width left_inherit_configs 1 0b10001L

let%test "left inherit 2" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width left_inherit_configs 2 0b10001L

let%test "left inherit 3" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width left_inherit_configs 3 0b10001L

let%test "left inherit 4" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width left_inherit_configs 4 0b10001L

let%test "left inherit 5" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width left_inherit_configs 5 0b10001L

let%test "left inherit 6" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width left_inherit_configs 6 0b10001L

let%test "left inherit 7" =
  [" 10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width left_inherit_configs 7 0b10001L

let%test "left inherit 8" =
  ["  10001L";"0b10001L";" 1_0001L";"0b1_0001L"] =
  test_width left_inherit_configs 8 0b10001L

let%test "left inherit 9" =
  ["   10001L";" 0b10001L";"  1_0001L";"0b1_0001L"] =
  test_width left_inherit_configs 9 0b10001L

let%test "left inherit 10" =
  ["    10001L";"  0b10001L";"   1_0001L";" 0b1_0001L"] =
  test_width left_inherit_configs 10 0b10001L

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width right_inherit_configs 1 0b10001L

let%test "right inherit 2" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width right_inherit_configs 2 0b10001L

let%test "right inherit 3" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width right_inherit_configs 3 0b10001L

let%test "right inherit 4" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width right_inherit_configs 4 0b10001L

let%test "right inherit 5" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width right_inherit_configs 5 0b10001L

let%test "right inherit 6" =
  ["10001L";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width right_inherit_configs 6 0b10001L

let%test "right inherit 7" =
  ["10001L ";"0b10001L";"1_0001L";"0b1_0001L"] =
  test_width right_inherit_configs 7 0b10001L

let%test "right inherit 8" =
  ["10001L  ";"0b10001L";"1_0001L ";"0b1_0001L"] =
  test_width right_inherit_configs 8 0b10001L

let%test "right inherit 9" =
  ["10001L   ";"0b10001L ";"1_0001L  ";"0b1_0001L"] =
  test_width right_inherit_configs 9 0b10001L

let%test "right inherit 10" =
  ["10001L    ";"0b10001L  ";"1_0001L   ";"0b1_0001L "] =
  test_width right_inherit_configs 10 0b10001L

(** * Large printing *)

let%test "zero inherit 17" =
  ["0000000000110111L";"0b00000000110111L";"0_0000_0011_0111L";"0b0000_0011_0111L"] =
  test_width zero_inherit_configs 17 0b110111L

let%test "left inherit 17" =
  ["          110111L";"        0b110111L";"         11_0111L";"       0b11_0111L"] =
  test_width left_inherit_configs 17 0b110111L

let%test "right inherit 16" =
  ["110111L          ";"0b110111L        ";"11_0111L         ";"0b11_0111L       "] =
  test_width right_inherit_configs 17 0b110111L

(** * -1 printing *)

let%test "zero inherit -1 1" =
  ["1111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width zero_inherit_configs 1 (-1L)

let%test "left inherit -1 1" =
  ["1111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width left_inherit_configs 1 (-1L)

let%test "right inherit -1 1" =
  ["1111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width right_inherit_configs 1 (-1L)

let%test "zero inherit -1 65" =
  ["1111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width zero_inherit_configs 65 (-1L)

let%test "left inherit -1 65" =
  ["1111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width left_inherit_configs 65 (-1L)

let%test "right inherit -1 65" =
  ["1111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width right_inherit_configs 65 (-1L)

let%test "zero inherit -1 66" =
  ["01111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width zero_inherit_configs 66 (-1L)

let%test "left inherit -1 66" =
  [" 1111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width left_inherit_configs 66 (-1L)

let%test "right inherit -1 66" =
  ["1111111111111111111111111111111111111111111111111111111111111111L "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width right_inherit_configs 66 (-1L)

let%test "zero inherit -1 67" =
  ["001111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width zero_inherit_configs 67 (-1L)

let%test "left inherit -1 67" =
  ["  1111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width left_inherit_configs 67 (-1L)

let%test "right inherit -1 67" =
  ["1111111111111111111111111111111111111111111111111111111111111111L  "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width right_inherit_configs 67 (-1L)

let%test "zero inherit -1 68" =
  ["0001111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b01111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width zero_inherit_configs 68 (-1L)

let%test "left inherit -1 68" =
  ["   1111111111111111111111111111111111111111111111111111111111111111L"
  ;" 0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width left_inherit_configs 68 (-1L)

let%test "right inherit -1 68" =
  ["1111111111111111111111111111111111111111111111111111111111111111L   "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L "
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width right_inherit_configs 68 (-1L)

let%test "zero inherit -1 79" =
  ["000000000000001111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b0000000000001111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width zero_inherit_configs 79 (-1L)

let%test "left inherit -1 79" =
  ["              1111111111111111111111111111111111111111111111111111111111111111L"
  ;"            0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width left_inherit_configs 79 (-1L)

let%test "right inherit -1 79" =
  ["1111111111111111111111111111111111111111111111111111111111111111L              "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L            "
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width right_inherit_configs 79 (-1L)

let%test "zero inherit -1 80" =
  ["0000000000000001111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b00000000000001111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width zero_inherit_configs 80 (-1L)

let%test "left inherit -1 80" =
  ["               1111111111111111111111111111111111111111111111111111111111111111L"
  ;"             0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width left_inherit_configs 80 (-1L)

let%test "right inherit -1 80" =
  ["1111111111111111111111111111111111111111111111111111111111111111L               "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L             "
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width right_inherit_configs 80 (-1L)

let%test "zero inherit -1 81" =
  ["00000000000000001111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b000000000000001111111111111111111111111111111111111111111111111111111111111111L"
  ;"01111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width zero_inherit_configs 81 (-1L)

let%test "left inherit -1 81" =
  ["                1111111111111111111111111111111111111111111111111111111111111111L"
  ;"              0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;" 1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width left_inherit_configs 81 (-1L)

let%test "right inherit -1 81" =
  ["1111111111111111111111111111111111111111111111111111111111111111L                "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L              "
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L "
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width right_inherit_configs 81 (-1L)

let%test "zero inherit -1 82" =
  ["000000000000000001111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b0000000000000001111111111111111111111111111111111111111111111111111111111111111L"
  ;"0_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width zero_inherit_configs 82 (-1L)

let%test "left inherit -1 82" =
  ["                 1111111111111111111111111111111111111111111111111111111111111111L"
  ;"               0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"  1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width left_inherit_configs 82 (-1L)

let%test "right inherit -1 82" =
  ["1111111111111111111111111111111111111111111111111111111111111111L                 "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L               "
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L  "
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width right_inherit_configs 82 (-1L)

let%test "zero inherit -1 83" =
  ["0000000000000000001111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b00000000000000001111111111111111111111111111111111111111111111111111111111111111L"
  ;"00_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b01111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width zero_inherit_configs 83 (-1L)

let%test "left inherit -1 83" =
  ["                  1111111111111111111111111111111111111111111111111111111111111111L"
  ;"                0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"   1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;" 0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width left_inherit_configs 83 (-1L)

let%test "right inherit -1 83" =
  ["1111111111111111111111111111111111111111111111111111111111111111L                  "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L                "
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L   "
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L "
  ] =
  test_width right_inherit_configs 83 (-1L)

let%test "zero inherit -1 84" =
  ["00000000000000000001111111111111111111111111111111111111111111111111111111111111111L"
  ;"0b000000000000000001111111111111111111111111111111111111111111111111111111111111111L"
  ;"000_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"0b0_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width zero_inherit_configs 84 (-1L)

let%test "left inherit -1 84" =
  ["                   1111111111111111111111111111111111111111111111111111111111111111L"
  ;"                 0b1111111111111111111111111111111111111111111111111111111111111111L"
  ;"    1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ;"  0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L"
  ] =
  test_width left_inherit_configs 84 (-1L)

let%test "right inherit -1 84" =
  ["1111111111111111111111111111111111111111111111111111111111111111L                   "
  ;"0b1111111111111111111111111111111111111111111111111111111111111111L                 "
  ;"1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L    "
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111L  "
  ] =
  test_width right_inherit_configs 84 (-1L)
