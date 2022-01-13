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

(** * One printing *)

let%test "one default" =
  "0b1L" =
  to_string 1L

let%test "one default manual" =
  "0b1L" =
  to_string_with ~flags:default ~min_width:1 1L

(** ** Zero Padding, OCaml *)

let%test "zero ocaml 1" =
  ["1L";"0b1L";"1L";"0b1L"] =
  test_width zero_ocaml_configs 1 1L

let%test "zero ocaml 2" =
  ["1L";"0b1L";"1L";"0b1L"] =
  test_width zero_ocaml_configs 2 1L

let%test "zero ocaml 3" =
  ["01L";"0b1L";"01L";"0b1L"] =
  test_width zero_ocaml_configs 3 1L

let%test "zero ocaml 4" =
  ["001L";"0b1L";"001L";"0b1L"] =
  test_width zero_ocaml_configs 4 1L

let%test "zero ocaml 5" =
  ["0001L";"0b01L";"0001L";"0b01L"] =
  test_width zero_ocaml_configs 5 1L

let%test "zero ocaml 6" =
  ["00001L";"0b001L";"00001L";"0b001L"] =
  test_width zero_ocaml_configs 6 1L

let%test "zero ocaml 7" =
  ["000001L";"0b0001L";"0_0001L";"0b0001L"] =
  test_width zero_ocaml_configs 7 1L

let%test "zero ocaml 8" =
  ["0000001L";"0b00001L";"00_0001L";"0b00001L"] =
  test_width zero_ocaml_configs 8 1L

let%test "zero ocaml 9" =
  ["00000001L";"0b000001L";"000_0001L";"0b0_0001L"] =
  test_width zero_ocaml_configs 9 1L

(** ** Left Padding, OCaml *)

let%test "left ocaml 1" =
  ["1L";"0b1L";"1L";"0b1L"] =
  test_width left_ocaml_configs 1 1L

let%test "left ocaml 2" =
  ["1L";"0b1L";"1L";"0b1L"] =
  test_width left_ocaml_configs 2 1L

let%test "left ocaml 3" =
  [" 1L";"0b1L";" 1L";"0b1L"] =
  test_width left_ocaml_configs 3 1L

let%test "left ocaml 4" =
  ["  1L";"0b1L";"  1L";"0b1L"] =
  test_width left_ocaml_configs 4 1L

let%test "left ocaml 5" =
  ["   1L";" 0b1L";"   1L";" 0b1L"] =
  test_width left_ocaml_configs 5 1L

(** ** Right Padding, OCaml *)

let%test "right ocaml 1" =
  ["1L";"0b1L";"1L";"0b1L"] =
  test_width right_ocaml_configs 1 1L

let%test "right ocaml 2" =
  ["1L";"0b1L";"1L";"0b1L"] =
  test_width right_ocaml_configs 2 1L

let%test "right ocaml 3" =
  ["1L ";"0b1L";"1L ";"0b1L"] =
  test_width right_ocaml_configs 3 1L

let%test "right ocaml 4" =
  ["1L  ";"0b1L";"1L  ";"0b1L"] =
  test_width right_ocaml_configs 4 1L

let%test "right ocaml 5" =
  ["1L   ";"0b1L ";"1L   ";"0b1L "] =
  test_width right_ocaml_configs 5 1L

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["1L";"0b1L";"1L";"0b1L"] =
  test_width zero_inherit_configs 1 1L

let%test "zero inherit 2" =
  ["1L";"0b1L";"1L";"0b1L"] =
  test_width zero_inherit_configs 2 1L

let%test "zero inherit 3" =
  ["01L";"0b1L";"01L";"0b1L"] =
  test_width zero_inherit_configs 3 1L

let%test "zero inherit 4" =
  ["001L";"0b1L";"001L";"0b1L"] =
  test_width zero_inherit_configs 4 1L

let%test "zero inherit 5" =
  ["0001L";"0b01L";"0001L";"0b01L"] =
  test_width zero_inherit_configs 5 1L

let%test "zero inherit 6" =
  ["00001L";"0b001L";"00001L";"0b001L"] =
  test_width zero_inherit_configs 6 1L

let%test "zero inherit 7" =
  ["000001L";"0b0001L";"0_0001L";"0b0001L"] =
  test_width zero_inherit_configs 7 1L

let%test "zero inherit 8" =
  ["0000001L";"0b00001L";"00_0001L";"0b00001L"] =
  test_width zero_inherit_configs 8 1L

let%test "zero inherit 9" =
  ["00000001L";"0b000001L";"000_0001L";"0b0_0001L"] =
  test_width zero_inherit_configs 9 1L

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["1L";"0b1L";"1L";"0b1L"] =
  test_width left_inherit_configs 1 1L

let%test "left inherit 2" =
  ["1L";"0b1L";"1L";"0b1L"] =
  test_width left_inherit_configs 2 1L

let%test "left inherit 3" =
  [" 1L";"0b1L";" 1L";"0b1L"] =
  test_width left_inherit_configs 3 1L

let%test "left inherit 4" =
  ["  1L";"0b1L";"  1L";"0b1L"] =
  test_width left_inherit_configs 4 1L

let%test "left inherit 5" =
  ["   1L";" 0b1L";"   1L";" 0b1L"] =
  test_width left_inherit_configs 5 1L

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["1L";"0b1L";"1L";"0b1L"] =
  test_width right_inherit_configs 1 1L

let%test "right inherit 2" =
  ["1L";"0b1L";"1L";"0b1L"] =
  test_width right_inherit_configs 2 1L

let%test "right inherit 3" =
  ["1L ";"0b1L";"1L ";"0b1L"] =
  test_width right_inherit_configs 3 1L

let%test "right inherit 4" =
  ["1L  ";"0b1L";"1L  ";"0b1L"] =
  test_width right_inherit_configs 4 1L

let%test "right inherit 5" =
  ["1L   ";"0b1L ";"1L   ";"0b1L "] =
  test_width right_inherit_configs 5 1L
