open Pp_binary_ints.Int64

open Pp_binary_ints.Flags

let configs =
  [ { default with separators = false; prefix_non_zero = false }
  ; { default with separators = false; prefix_non_zero = true }
  ; { default with separators = true; prefix_non_zero = false }
  ; { default with separators = true; prefix_non_zero = true }
  ]

let zero_ocaml_configs =
  List.map (fun x -> { x with padding = Zeros; zero_printing = OCaml }) configs

let left_ocaml_configs =
  List.map (fun x -> { x with padding = Left; zero_printing = OCaml }) configs

let right_ocaml_configs =
  List.map (fun x -> { x with padding = Right; zero_printing = OCaml }) configs

let zero_inherit_configs =
  List.map (fun x -> { x with padding = Zeros; zero_printing = InheritNonZero }) configs

let left_inherit_configs =
  List.map (fun x -> { x with padding = Left; zero_printing = InheritNonZero }) configs

let right_inherit_configs =
  List.map (fun x -> { x with padding = Right; zero_printing = InheritNonZero }) configs

let test_width configs min_width n : string list =
  List.map (fun flags -> to_string_with ~flags ~min_width n) configs

(** * Zero printing *)

let%test "zero default" =
  "0b0L" =
  to_string 0L

let%test "zero default manual" =
  "0b0L" =
  to_string_with ~flags:default ~min_width:1 0L

(** ** Zero Padding, OCaml *)

(** OCaml's [Printf] does not prefix zeros *)

let%test "zero ocaml 1" =
  ["0L";"0L";"0L";"0L"] =
  test_width zero_ocaml_configs 1 0L

let%test "zero ocaml 2" =
  ["0L";"0L";"0L";"0L"] =
  test_width zero_ocaml_configs 2 0L

let%test "zero ocaml 3" =
  ["00L";"00L";"00L";"00L"] =
  test_width zero_ocaml_configs 3 0L

let%test "zero ocaml 4" =
  ["000L";"000L";"000L";"000L"] =
  test_width zero_ocaml_configs 4 0L

let%test "zero ocaml 5" =
  ["0000L";"0000L";"0000L";"0000L"] =
  test_width zero_ocaml_configs 5 0L

let%test "zero ocaml 6" =
  ["00000L";"00000L";"00000L";"00000L"] =
  test_width zero_ocaml_configs 6 0L

let%test "zero ocaml 7" =
  ["000000L";"000000L";"0_0000L";"0_0000L"] =
  test_width zero_ocaml_configs 7 0L

let%test "zero ocaml 16" =
  ["000000000000000L"
  ;"000000000000000L"
  ;"00000_0000_0000L"
  ;"00000_0000_0000L"
  ] =
  test_width zero_ocaml_configs 16 0L

let%test "zero ocaml 17" =
  ["0000000000000000L"
  ;"0000000000000000L"
  ;"0_0000_0000_0000L"
  ;"0_0000_0000_0000L"
  ] =
  test_width zero_ocaml_configs 17 0L

(** ** Left Padding, OCaml *)

let%test "left ocaml 1" =
  ["0L";"0L";"0L";"0L"] =
  test_width left_ocaml_configs 1 0L

let%test "left ocaml 2" =
  ["0L";"0L";"0L";"0L"] =
  test_width left_ocaml_configs 2 0L

let%test "left ocaml 3" =
  [" 0L";" 0L";" 0L";" 0L"] =
  test_width left_ocaml_configs 3 0L

let%test "left ocaml 4" =
  ["  0L";"  0L";"  0L";"  0L"] =
  test_width left_ocaml_configs 4 0L

let%test "left ocaml 5" =
  ["   0L";"   0L";"   0L";"   0L"] =
  test_width left_ocaml_configs 5 0L

(** ** Right Padding, OCaml *)

let%test "right ocaml 1" =
  ["0L";"0L";"0L";"0L"] =
  test_width right_ocaml_configs 1 0L

let%test "right ocaml 2" =
  ["0L";"0L";"0L";"0L"] =
  test_width right_ocaml_configs 2 0L

let%test "right ocaml 3" =
  ["0L ";"0L ";"0L ";"0L "] =
  test_width right_ocaml_configs 3 0L

let%test "right ocaml 4" =
  ["0L  ";"0L  ";"0L  ";"0L  "] =
  test_width right_ocaml_configs 4 0L

let%test "right ocaml 5" =
  ["0L   ";"0L   ";"0L   ";"0L   "] =
  test_width right_ocaml_configs 5 0L

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["0L";"0b0L";"0L";"0b0L"] =
  test_width zero_inherit_configs 1 0L

let%test "zero inherit 2" =
  ["0L";"0b0L";"0L";"0b0L"] =
  test_width zero_inherit_configs 2 0L

let%test "zero inherit 3" =
  ["00L";"0b0L";"00L";"0b0L"] =
  test_width zero_inherit_configs 3 0L

let%test "zero inherit 4" =
  ["000L";"0b0L";"000L";"0b0L"] =
  test_width zero_inherit_configs 4 0L

let%test "zero inherit 5" =
  ["0000L";"0b00L";"0000L";"0b00L"] =
  test_width zero_inherit_configs 5 0L

let%test "zero inherit 6" =
  ["00000L";"0b000L";"00000L";"0b000L"] =
  test_width zero_inherit_configs 6 0L

let%test "zero inherit 7" =
  ["000000L";"0b0000L";"0_0000L";"0b0000L"] =
  test_width zero_inherit_configs 7 0L

let%test "zero inherit 8" =
  ["0000000L";"0b00000L";"00_0000L";"0b00000L"] =
  test_width zero_inherit_configs 8 0L

let%test "zero inherit 9" =
  ["00000000L";"0b000000L";"000_0000L";"0b0_0000L"] =
  test_width zero_inherit_configs 9 0L

let%test "zero inherit 16" =
  ["000000000000000L"
  ;"0b0000000000000L"
  ;"00000_0000_0000L"
  ;"0b000_0000_0000L"
  ] =
  test_width zero_inherit_configs 16 0L

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["0L";"0b0L";"0L";"0b0L"] =
  test_width left_inherit_configs 1 0L

let%test "left inherit 2" =
  ["0L";"0b0L";"0L";"0b0L"] =
  test_width left_inherit_configs 2 0L

let%test "left inherit 3" =
  [" 0L";"0b0L";" 0L";"0b0L"] =
  test_width left_inherit_configs 3 0L

let%test "left inherit 4" =
  ["  0L";"0b0L";"  0L";"0b0L"] =
  test_width left_inherit_configs 4 0L

let%test "left inherit 5" =
  ["   0L";" 0b0L";"   0L";" 0b0L"] =
  test_width left_inherit_configs 5 0L

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["0L";"0b0L";"0L";"0b0L"] =
  test_width right_inherit_configs 1 0L

let%test "right inherit 2" =
  ["0L";"0b0L";"0L";"0b0L"] =
  test_width right_inherit_configs 2 0L

let%test "right inherit 3" =
  ["0L ";"0b0L";"0L ";"0b0L"] =
  test_width right_inherit_configs 3 0L

let%test "right inherit 4" =
  ["0L  ";"0b0L";"0L  ";"0b0L"] =
  test_width right_inherit_configs 4 0L

let%test "right inherit 5" =
  ["0L   ";"0b0L ";"0L   ";"0b0L "] =
  test_width right_inherit_configs 5 0L
