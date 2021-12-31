open Pp_binary_ints.Int32

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
  "101l" =
  to_string 0b101l

let%test "one default manual" =
  "101l" =
  to_string_with ~flags:default ~min_width:1 0b101l

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["101l";"0b101l";"101l";"0b101l"] =
  test_width zero_inherit_configs 1 0b101l

let%test "zero inherit 2" =
  ["101l";"0b101l";"101l";"0b101l"] =
  test_width zero_inherit_configs 2 0b101l

let%test "zero inherit 3" =
  ["101l";"0b101l";"101l";"0b101l"] =
  test_width zero_inherit_configs 3 0b101l

let%test "zero inherit 4" =
  ["101l";"0b101l";"101l";"0b101l"] =
  test_width zero_inherit_configs 4 0b101l

let%test "zero inherit 5" =
  ["0101l"
  ;"0b101l"
  ;"0101l"
  ;"0b101l"
  ] =
  test_width zero_inherit_configs 5 0b101l

let%test "zero inherit 6" =
  ["00101l"
  ;"0b101l"
  ;"00101l"
  ;"0b101l"
  ] =
  test_width zero_inherit_configs 6 0b101l

let%test "zero inherit 7" =
  ["000101l"
  ;"0b0101l"
  ;"0_0101l"
  ;"0b0101l"] =
  test_width zero_inherit_configs 7 0b101l

let%test "zero inherit 8" =
  ["0000101l"
  ;"0b00101l"
  ;"00_0101l"
  ;"0b00101l"] =
  test_width zero_inherit_configs 8 0b101l

let%test "zero inherit 9" =
  ["00000101l"
  ;"0b000101l"
  ;"000_0101l"
  ;"0b0_0101l"] =
  test_width zero_inherit_configs 9 0b101l

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["101l";"0b101l";"101l";"0b101l"] =
  test_width left_inherit_configs 1 0b101l

let%test "left inherit 2" =
  ["101l";"0b101l";"101l";"0b101l"] =
  test_width left_inherit_configs 2 0b101l

let%test "left inherit 3" =
  ["101l";"0b101l";"101l";"0b101l"] =
  test_width left_inherit_configs 3 0b101l

let%test "left inherit 4" =
  ["101l";"0b101l";"101l";"0b101l"] =
  test_width left_inherit_configs 4 0b101l

let%test "left inherit 5" =
  [" 101l";"0b101l";" 101l";"0b101l"] =
  test_width left_inherit_configs 5 0b101l

let%test "left inherit 6" =
  ["  101l";"0b101l";"  101l";"0b101l"] =
  test_width left_inherit_configs 6 0b101l

let%test "left inherit 7" =
  ["   101l";" 0b101l";"   101l";" 0b101l"] =
  test_width left_inherit_configs 7 0b101l

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["101l";"0b101l";"101l";"0b101l"] =
  test_width right_inherit_configs 1 0b101l

let%test "right inherit 2" =
  ["101l";"0b101l";"101l";"0b101l"] =
  test_width right_inherit_configs 2 0b101l

let%test "right inherit 3" =
  ["101l";"0b101l";"101l";"0b101l"] =
  test_width right_inherit_configs 3 0b101l

let%test "right inherit 4" =
  ["101l";"0b101l";"101l";"0b101l"] =
  test_width right_inherit_configs 4 0b101l

let%test "right inherit 5" =
  ["101l ";"0b101l";"101l ";"0b101l"] =
  test_width right_inherit_configs 5 0b101l

let%test "right inherit 6" =
  ["101l  ";"0b101l";"101l  ";"0b101l"] =
  test_width right_inherit_configs 6 0b101l

let%test "right inherit 7" =
  ["101l   ";"0b101l ";"101l   ";"0b101l "] =
  test_width right_inherit_configs 7 0b101l

(** * Eight printing *)

let%test "one default" =
  "1000l" =
  to_string 0b1000l

let%test "one default manual" =
  "1000l" =
  to_string_with ~flags:default ~min_width:1 0b1000l

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width zero_inherit_configs 1 0b1000l

let%test "zero inherit 2" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width zero_inherit_configs 2 0b1000l

let%test "zero inherit 3" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width zero_inherit_configs 3 0b1000l

let%test "zero inherit 4" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width zero_inherit_configs 4 0b1000l

let%test "zero inherit 5" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width zero_inherit_configs 5 0b1000l

let%test "zero inherit 6" =
  ["01000l";"0b1000l";"01000l";"0b1000l"] =
  test_width zero_inherit_configs 6 0b1000l

let%test "zero inherit 7" =
  ["001000l";"0b1000l";"0_1000l";"0b1000l"] =
  test_width zero_inherit_configs 7 0b1000l

let%test "zero inherit 8" =
  ["0001000l";"0b01000l";"00_1000l";"0b01000l"] =
  test_width zero_inherit_configs 8 0b1000l

let%test "zero inherit 9" =
  ["00001000l";"0b001000l";"000_1000l";"0b0_1000l"] =
  test_width zero_inherit_configs 9 0b1000l

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width left_inherit_configs 1 0b1000l

let%test "left inherit 2" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width left_inherit_configs 2 0b1000l

let%test "left inherit 3" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width left_inherit_configs 3 0b1000l

let%test "left inherit 4" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width left_inherit_configs 4 0b1000l

let%test "left inherit 5" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width left_inherit_configs 5 0b1000l

let%test "left inherit 6" =
  [" 1000l";"0b1000l";" 1000l";"0b1000l"] =
  test_width left_inherit_configs 6 0b1000l

let%test "left inherit 7" =
  ["  1000l";"0b1000l";"  1000l";"0b1000l"] =
  test_width left_inherit_configs 7 0b1000l

let%test "left inherit 8" =
  ["   1000l";" 0b1000l";"   1000l";" 0b1000l"] =
  test_width left_inherit_configs 8 0b1000l

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width right_inherit_configs 1 0b1000l

let%test "right inherit 2" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width right_inherit_configs 2 0b1000l

let%test "right inherit 3" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width right_inherit_configs 3 0b1000l

let%test "right inherit 4" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width right_inherit_configs 4 0b1000l

let%test "right inherit 5" =
  ["1000l";"0b1000l";"1000l";"0b1000l"] =
  test_width right_inherit_configs 5 0b1000l

let%test "right inherit 6" =
  ["1000l ";"0b1000l";"1000l ";"0b1000l"] =
  test_width right_inherit_configs 6 0b1000l

let%test "right inherit 7" =
  ["1000l  ";"0b1000l";"1000l  ";"0b1000l"] =
  test_width right_inherit_configs 7 0b1000l

let%test "right inherit 8" =
  ["1000l   ";"0b1000l ";"1000l   ";"0b1000l "] =
  test_width right_inherit_configs 8 0b1000l

(** * Seventeen printing *)

let%test "one default" =
  "10001l" =
  to_string 0b10001l

let%test "one default manual" =
  "10001l" =
  to_string_with ~flags:default ~min_width:1 0b10001l

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width zero_inherit_configs 1 0b10001l

let%test "zero inherit 2" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width zero_inherit_configs 2 0b10001l

let%test "zero inherit 3" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width zero_inherit_configs 3 0b10001l

let%test "zero inherit 4" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width zero_inherit_configs 4 0b10001l

let%test "zero inherit 5" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width zero_inherit_configs 5 0b10001l

let%test "zero inherit 6" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width zero_inherit_configs 6 0b10001l

let%test "zero inherit 7" =
  ["010001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width zero_inherit_configs 7 0b10001l

let%test "zero inherit 8" =
  ["0010001l";"0b10001l";"01_0001l";"0b1_0001l"] =
  test_width zero_inherit_configs 8 0b10001l

let%test "zero inherit 9" =
  ["00010001l";"0b010001l";"001_0001l";"0b1_0001l"] =
  test_width zero_inherit_configs 9 0b10001l

let%test "zero inherit 10" =
  ["000010001l"
  ;"0b0010001l"
  ;"0001_0001l"
  ;"0b01_0001l"] =
  test_width zero_inherit_configs 10 0b10001l

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width left_inherit_configs 1 0b10001l

let%test "left inherit 2" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width left_inherit_configs 2 0b10001l

let%test "left inherit 3" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width left_inherit_configs 3 0b10001l

let%test "left inherit 4" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width left_inherit_configs 4 0b10001l

let%test "left inherit 5" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width left_inherit_configs 5 0b10001l

let%test "left inherit 6" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width left_inherit_configs 6 0b10001l

let%test "left inherit 7" =
  [" 10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width left_inherit_configs 7 0b10001l

let%test "left inherit 8" =
  ["  10001l";"0b10001l";" 1_0001l";"0b1_0001l"] =
  test_width left_inherit_configs 8 0b10001l

let%test "left inherit 9" =
  ["   10001l";" 0b10001l";"  1_0001l";"0b1_0001l"] =
  test_width left_inherit_configs 9 0b10001l

let%test "left inherit 10" =
  ["    10001l";"  0b10001l";"   1_0001l";" 0b1_0001l"] =
  test_width left_inherit_configs 10 0b10001l

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width right_inherit_configs 1 0b10001l

let%test "right inherit 2" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width right_inherit_configs 2 0b10001l

let%test "right inherit 3" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width right_inherit_configs 3 0b10001l

let%test "right inherit 4" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width right_inherit_configs 4 0b10001l

let%test "right inherit 5" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width right_inherit_configs 5 0b10001l

let%test "right inherit 6" =
  ["10001l";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width right_inherit_configs 6 0b10001l

let%test "right inherit 7" =
  ["10001l ";"0b10001l";"1_0001l";"0b1_0001l"] =
  test_width right_inherit_configs 7 0b10001l

let%test "right inherit 8" =
  ["10001l  ";"0b10001l";"1_0001l ";"0b1_0001l"] =
  test_width right_inherit_configs 8 0b10001l

let%test "right inherit 9" =
  ["10001l   ";"0b10001l ";"1_0001l  ";"0b1_0001l"] =
  test_width right_inherit_configs 9 0b10001l

let%test "right inherit 10" =
  ["10001l    ";"0b10001l  ";"1_0001l   ";"0b1_0001l "] =
  test_width right_inherit_configs 10 0b10001l

(** * Large printing *)

let%test "zero inherit 17" =
  ["0000000000110111l";"0b00000000110111l";"0_0000_0011_0111l";"0b0000_0011_0111l"] =
  test_width zero_inherit_configs 17 0b110111l

let%test "left inherit 17" =
  ["          110111l";"        0b110111l";"         11_0111l";"       0b11_0111l"] =
  test_width left_inherit_configs 17 0b110111l

let%test "right inherit 16" =
  ["110111l          ";"0b110111l        ";"11_0111l         ";"0b11_0111l       "] =
  test_width right_inherit_configs 17 0b110111l

(** * -1 printing *)

let%test "zero inherit -1 1" =
  ["11111111111111111111111111111111l"
  ;"0b11111111111111111111111111111111l"
  ;"1111_1111_1111_1111_1111_1111_1111_1111l"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111l"
  ] =
  test_width zero_inherit_configs 1 (-1l)

let%test "left inherit -1l 1" =
  ["11111111111111111111111111111111l"
  ;"0b11111111111111111111111111111111l"
  ;"1111_1111_1111_1111_1111_1111_1111_1111l"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111l"
  ] =
  test_width left_inherit_configs 1 (-1l)

let%test "right inherit -1l 1" =
  ["11111111111111111111111111111111l"
  ;"0b11111111111111111111111111111111l"
  ;"1111_1111_1111_1111_1111_1111_1111_1111l"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111l"
  ] =
  test_width right_inherit_configs 1 (-1l)

let%test "zero inherit -1l 34" =
  ["011111111111111111111111111111111l"
  ;"0b11111111111111111111111111111111l"
  ;"1111_1111_1111_1111_1111_1111_1111_1111l"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111l"
  ] =
  test_width zero_inherit_configs 34 (-1l)

let%test "left inherit -1l 34" =
  [" 11111111111111111111111111111111l"
  ;"0b11111111111111111111111111111111l"
  ;"1111_1111_1111_1111_1111_1111_1111_1111l"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111l"
  ] =
  test_width left_inherit_configs 34 (-1l)

let%test "right inherit -1l 34" =
  ["11111111111111111111111111111111l "
  ;"0b11111111111111111111111111111111l"
  ;"1111_1111_1111_1111_1111_1111_1111_1111l"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111l"
  ] =
  test_width right_inherit_configs 34 (-1l)

let%test "zero inherit -1l 35" =
  ["0011111111111111111111111111111111l"
  ;"0b11111111111111111111111111111111l"
  ;"1111_1111_1111_1111_1111_1111_1111_1111l"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111l"
  ] =
  test_width zero_inherit_configs 35 (-1l)

let%test "left inherit -1l 35" =
  ["  11111111111111111111111111111111l"
  ;"0b11111111111111111111111111111111l"
  ;"1111_1111_1111_1111_1111_1111_1111_1111l"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111l"
  ] =
  test_width left_inherit_configs 35 (-1l)

let%test "right inherit -1l 35" =
  ["11111111111111111111111111111111l  "
  ;"0b11111111111111111111111111111111l"
  ;"1111_1111_1111_1111_1111_1111_1111_1111l"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111l"
  ] =
  test_width right_inherit_configs 35 (-1l)

let%test "zero inherit -1l 36" =
  ["00011111111111111111111111111111111l"
  ;"0b011111111111111111111111111111111l"
  ;"1111_1111_1111_1111_1111_1111_1111_1111l"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111l"
  ] =
  test_width zero_inherit_configs 36 (-1l)

let%test "left inherit -1l 36" =
  ["   11111111111111111111111111111111l"
  ;" 0b11111111111111111111111111111111l"
  ;"1111_1111_1111_1111_1111_1111_1111_1111l"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111l"
  ] =
  test_width left_inherit_configs 36 (-1l)

let%test "right inherit -1l 36" =
  ["11111111111111111111111111111111l   "
  ;"0b11111111111111111111111111111111l "
  ;"1111_1111_1111_1111_1111_1111_1111_1111l"
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111l"
  ] =
  test_width right_inherit_configs 36 (-1l)

let%test "zero inherit -1l 78" =
  ["00000000000000000000000000000000000000000000011111111111111111111111111111111l"
  ;"0b000000000000000000000000000000000000000000011111111111111111111111111111111l"
  ;"00_0000_0000_0000_0000_0000_0000_0000_1111_1111_1111_1111_1111_1111_1111_1111l"
  ;"0b00000_0000_0000_0000_0000_0000_0000_1111_1111_1111_1111_1111_1111_1111_1111l"
  ] =
  test_width zero_inherit_configs 78 (-1l)

let%test "left inherit -1l 78" =
  ["                                             11111111111111111111111111111111l"
  ;"                                           0b11111111111111111111111111111111l"
  ;"                                      1111_1111_1111_1111_1111_1111_1111_1111l"
  ;"                                    0b1111_1111_1111_1111_1111_1111_1111_1111l"
  ] =
  test_width left_inherit_configs 78 (-1l)

let%test "right inherit -1l 78" =
  ["11111111111111111111111111111111l                                             "
  ;"0b11111111111111111111111111111111l                                           "
  ;"1111_1111_1111_1111_1111_1111_1111_1111l                                      "
  ;"0b1111_1111_1111_1111_1111_1111_1111_1111l                                    "
  ] =
  test_width right_inherit_configs 78 (-1l)
