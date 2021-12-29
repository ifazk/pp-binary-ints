open Pp_binary_ints.Int

open Flags

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
  "101" =
  to_string 0b101

let%test "one default manual" =
  "101" =
  to_string_with ~flags:default ~min_width:1 0b101

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["101";"0b101";"101";"0b101"] =
  test_width zero_inherit_configs 1 0b101

let%test "zero inherit 2" =
  ["101";"0b101";"101";"0b101"] =
  test_width zero_inherit_configs 2 0b101

let%test "zero inherit 3" =
  ["101";"0b101";"101";"0b101"] =
  test_width zero_inherit_configs 3 0b101

let%test "zero inherit 4" =
  ["0101";"0b101";"0101";"0b101"] =
  test_width zero_inherit_configs 4 0b101

let%test "zero inherit 5" =
  ["00101";"0b101";"00101";"0b101"] =
  test_width zero_inherit_configs 5 0b101

let%test "zero inherit 6" =
  ["000101";"0b0101";"0_0101";"0b0101"] =
  test_width zero_inherit_configs 6 0b101

let%test "zero inherit 7" =
  ["0000101";"0b00101";"00_0101";"0b00101"] =
  test_width zero_inherit_configs 7 0b101

let%test "zero inherit 8" =
  ["00000101";"0b000101";"000_0101";"0b0_0101"] =
  test_width zero_inherit_configs 8 0b101

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["101";"0b101";"101";"0b101"] =
  test_width left_inherit_configs 1 0b101

let%test "left inherit 2" =
  ["101";"0b101";"101";"0b101"] =
  test_width left_inherit_configs 2 0b101

let%test "left inherit 3" =
  ["101";"0b101";"101";"0b101"] =
  test_width left_inherit_configs 3 0b101

let%test "left inherit 4" =
  [" 101";"0b101";" 101";"0b101"] =
  test_width left_inherit_configs 4 0b101

let%test "left inherit 5" =
  ["  101";"0b101";"  101";"0b101"] =
  test_width left_inherit_configs 5 0b101

let%test "left inherit 6" =
  ["   101";" 0b101";"   101";" 0b101"] =
  test_width left_inherit_configs 6 0b101

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["101";"0b101";"101";"0b101"] =
  test_width right_inherit_configs 1 0b101

let%test "right inherit 2" =
  ["101";"0b101";"101";"0b101"] =
  test_width right_inherit_configs 2 0b101

let%test "right inherit 3" =
  ["101";"0b101";"101";"0b101"] =
  test_width right_inherit_configs 3 0b101

let%test "right inherit 4" =
  ["101 ";"0b101";"101 ";"0b101"] =
  test_width right_inherit_configs 4 0b101

let%test "right inherit 5" =
  ["101  ";"0b101";"101  ";"0b101"] =
  test_width right_inherit_configs 5 0b101

let%test "right inherit 6" =
  ["101   ";"0b101 ";"101   ";"0b101 "] =
  test_width right_inherit_configs 6 0b101

(** * Eight printing *)

let%test "one default" =
  "1000" =
  to_string 0b1000

let%test "one default manual" =
  "1000" =
  to_string_with ~flags:default ~min_width:1 0b1000

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["1000";"0b1000";"1000";"0b1000"] =
  test_width zero_inherit_configs 1 0b1000

let%test "zero inherit 2" =
  ["1000";"0b1000";"1000";"0b1000"] =
  test_width zero_inherit_configs 2 0b1000

let%test "zero inherit 3" =
  ["1000";"0b1000";"1000";"0b1000"] =
  test_width zero_inherit_configs 3 0b1000

let%test "zero inherit 4" =
  ["1000";"0b1000";"1000";"0b1000"] =
  test_width zero_inherit_configs 4 0b1000

let%test "zero inherit 5" =
  ["01000";"0b1000";"01000";"0b1000"] =
  test_width zero_inherit_configs 5 0b1000

let%test "zero inherit 6" =
  ["001000";"0b1000";"0_1000";"0b1000"] =
  test_width zero_inherit_configs 6 0b1000

let%test "zero inherit 7" =
  ["0001000";"0b01000";"00_1000";"0b01000"] =
  test_width zero_inherit_configs 7 0b1000

let%test "zero inherit 8" =
  ["00001000";"0b001000";"000_1000";"0b0_1000"] =
  test_width zero_inherit_configs 8 0b1000

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["1000";"0b1000";"1000";"0b1000"] =
  test_width left_inherit_configs 1 0b1000

let%test "left inherit 2" =
  ["1000";"0b1000";"1000";"0b1000"] =
  test_width left_inherit_configs 2 0b1000

let%test "left inherit 3" =
  ["1000";"0b1000";"1000";"0b1000"] =
  test_width left_inherit_configs 3 0b1000

let%test "left inherit 4" =
  ["1000";"0b1000";"1000";"0b1000"] =
  test_width left_inherit_configs 4 0b1000

let%test "left inherit 5" =
  [" 1000";"0b1000";" 1000";"0b1000"] =
  test_width left_inherit_configs 5 0b1000

let%test "left inherit 6" =
  ["  1000";"0b1000";"  1000";"0b1000"] =
  test_width left_inherit_configs 6 0b1000

let%test "left inherit 7" =
  ["   1000";" 0b1000";"   1000";" 0b1000"] =
  test_width left_inherit_configs 7 0b1000

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["1000";"0b1000";"1000";"0b1000"] =
  test_width right_inherit_configs 1 0b1000

let%test "right inherit 2" =
  ["1000";"0b1000";"1000";"0b1000"] =
  test_width right_inherit_configs 2 0b1000

let%test "right inherit 3" =
  ["1000";"0b1000";"1000";"0b1000"] =
  test_width right_inherit_configs 3 0b1000

let%test "right inherit 4" =
  ["1000";"0b1000";"1000";"0b1000"] =
  test_width right_inherit_configs 4 0b1000

let%test "right inherit 5" =
  ["1000 ";"0b1000";"1000 ";"0b1000"] =
  test_width right_inherit_configs 5 0b1000

let%test "right inherit 6" =
  ["1000  ";"0b1000";"1000  ";"0b1000"] =
  test_width right_inherit_configs 6 0b1000

let%test "right inherit 7" =
  ["1000   ";"0b1000 ";"1000   ";"0b1000 "] =
  test_width right_inherit_configs 7 0b1000

(** * Seventeen printing *)

let%test "one default" =
  "10001" =
  to_string 0b10001

let%test "one default manual" =
  "10001" =
  to_string_with ~flags:default ~min_width:1 0b10001

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width zero_inherit_configs 1 0b10001

let%test "zero inherit 2" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width zero_inherit_configs 2 0b10001

let%test "zero inherit 3" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width zero_inherit_configs 3 0b10001

let%test "zero inherit 4" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width zero_inherit_configs 4 0b10001

let%test "zero inherit 5" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width zero_inherit_configs 5 0b10001

let%test "zero inherit 6" =
  ["010001";"0b10001";"1_0001";"0b1_0001"] =
  test_width zero_inherit_configs 6 0b10001

let%test "zero inherit 7" =
  ["0010001";"0b10001";"01_0001";"0b1_0001"] =
  test_width zero_inherit_configs 7 0b10001

let%test "zero inherit 8" =
  ["00010001";"0b010001";"001_0001";"0b1_0001"] =
  test_width zero_inherit_configs 8 0b10001

let%test "zero inherit 9" =
  ["000010001";"0b0010001";"0001_0001";"0b01_0001"] =
  test_width zero_inherit_configs 9 0b10001

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width left_inherit_configs 1 0b10001

let%test "left inherit 2" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width left_inherit_configs 2 0b10001

let%test "left inherit 3" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width left_inherit_configs 3 0b10001

let%test "left inherit 4" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width left_inherit_configs 4 0b10001

let%test "left inherit 5" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width left_inherit_configs 5 0b10001

let%test "left inherit 6" =
  [" 10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width left_inherit_configs 6 0b10001

let%test "left inherit 7" =
  ["  10001";"0b10001";" 1_0001";"0b1_0001"] =
  test_width left_inherit_configs 7 0b10001

let%test "left inherit 8" =
  ["   10001";" 0b10001";"  1_0001";"0b1_0001"] =
  test_width left_inherit_configs 8 0b10001

let%test "left inherit 9" =
  ["    10001";"  0b10001";"   1_0001";" 0b1_0001"] =
  test_width left_inherit_configs 9 0b10001

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width right_inherit_configs 1 0b10001

let%test "right inherit 2" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width right_inherit_configs 2 0b10001

let%test "right inherit 3" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width right_inherit_configs 3 0b10001

let%test "right inherit 4" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width right_inherit_configs 4 0b10001

let%test "right inherit 5" =
  ["10001";"0b10001";"1_0001";"0b1_0001"] =
  test_width right_inherit_configs 5 0b10001

let%test "right inherit 6" =
  ["10001 ";"0b10001";"1_0001";"0b1_0001"] =
  test_width right_inherit_configs 6 0b10001

let%test "right inherit 7" =
  ["10001  ";"0b10001";"1_0001 ";"0b1_0001"] =
  test_width right_inherit_configs 7 0b10001

let%test "right inherit 8" =
  ["10001   ";"0b10001 ";"1_0001  ";"0b1_0001"] =
  test_width right_inherit_configs 8 0b10001

let%test "right inherit 9" =
  ["10001    ";"0b10001  ";"1_0001   ";"0b1_0001 "] =
  test_width right_inherit_configs 9 0b10001

(** * Large printing *)

let%test "zero inherit 16" =
  ["0000000000110111";"0b00000000110111";"0_0000_0011_0111";"0b0000_0011_0111"] =
  test_width zero_inherit_configs 16 0b110111

let%test "left inherit 16" =
  ["          110111";"        0b110111";"         11_0111";"       0b11_0111"] =
  test_width left_inherit_configs 16 0b110111

let%test "right inherit 16" =
  ["110111          ";"0b110111        ";"11_0111         ";"0b11_0111       "] =
  test_width right_inherit_configs 16 0b110111
