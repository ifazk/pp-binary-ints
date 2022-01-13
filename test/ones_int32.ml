open Pp_binary_ints.Int32

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
  "0b1l" =
  to_string 1l

let%test "one default manual" =
  "0b1l" =
  to_string_with ~flags:default ~min_width:1 1l

(** ** Zero Padding, OCaml *)

let%test "zero ocaml 1" =
  ["1l";"0b1l";"1l";"0b1l"] =
  test_width zero_ocaml_configs 1 1l

let%test "zero ocaml 2" =
  ["1l";"0b1l";"1l";"0b1l"] =
  test_width zero_ocaml_configs 2 1l

let%test "zero ocaml 3" =
  ["01l";"0b1l";"01l";"0b1l"] =
  test_width zero_ocaml_configs 3 1l

let%test "zero ocaml 4" =
  ["001l";"0b1l";"001l";"0b1l"] =
  test_width zero_ocaml_configs 4 1l

let%test "zero ocaml 5" =
  ["0001l";"0b01l";"0001l";"0b01l"] =
  test_width zero_ocaml_configs 5 1l

let%test "zero ocaml 6" =
  ["00001l";"0b001l";"00001l";"0b001l"] =
  test_width zero_ocaml_configs 6 1l

let%test "zero ocaml 7" =
  ["000001l";"0b0001l";"0_0001l";"0b0001l"] =
  test_width zero_ocaml_configs 7 1l

let%test "zero ocaml 8" =
  ["0000001l";"0b00001l";"00_0001l";"0b00001l"] =
  test_width zero_ocaml_configs 8 1l

let%test "zero ocaml 9" =
  ["00000001l";"0b000001l";"000_0001l";"0b0_0001l"] =
  test_width zero_ocaml_configs 9 1l

(** ** Left Padding, OCaml *)

let%test "left ocaml 1" =
  ["1l";"0b1l";"1l";"0b1l"] =
  test_width left_ocaml_configs 1 1l

let%test "left ocaml 2" =
  ["1l";"0b1l";"1l";"0b1l"] =
  test_width left_ocaml_configs 2 1l

let%test "left ocaml 3" =
  [" 1l";"0b1l";" 1l";"0b1l"] =
  test_width left_ocaml_configs 3 1l

let%test "left ocaml 4" =
  ["  1l";"0b1l";"  1l";"0b1l"] =
  test_width left_ocaml_configs 4 1l

let%test "left ocaml 5" =
  ["   1l";" 0b1l";"   1l";" 0b1l"] =
  test_width left_ocaml_configs 5 1l

(** ** Right Padding, OCaml *)

let%test "right ocaml 1" =
  ["1l";"0b1l";"1l";"0b1l"] =
  test_width right_ocaml_configs 1 1l

let%test "right ocaml 2" =
  ["1l";"0b1l";"1l";"0b1l"] =
  test_width right_ocaml_configs 2 1l

let%test "right ocaml 3" =
  ["1l ";"0b1l";"1l ";"0b1l"] =
  test_width right_ocaml_configs 3 1l

let%test "right ocaml 4" =
  ["1l  ";"0b1l";"1l  ";"0b1l"] =
  test_width right_ocaml_configs 4 1l

let%test "right ocaml 5" =
  ["1l   ";"0b1l ";"1l   ";"0b1l "] =
  test_width right_ocaml_configs 5 1l

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["1l";"0b1l";"1l";"0b1l"] =
  test_width zero_inherit_configs 1 1l

let%test "zero inherit 2" =
  ["1l";"0b1l";"1l";"0b1l"] =
  test_width zero_inherit_configs 2 1l

let%test "zero inherit 3" =
  ["01l";"0b1l";"01l";"0b1l"] =
  test_width zero_inherit_configs 3 1l

let%test "zero inherit 4" =
  ["001l";"0b1l";"001l";"0b1l"] =
  test_width zero_inherit_configs 4 1l

let%test "zero inherit 5" =
  ["0001l";"0b01l";"0001l";"0b01l"] =
  test_width zero_inherit_configs 5 1l

let%test "zero inherit 6" =
  ["00001l";"0b001l";"00001l";"0b001l"] =
  test_width zero_inherit_configs 6 1l

let%test "zero inherit 7" =
  ["000001l";"0b0001l";"0_0001l";"0b0001l"] =
  test_width zero_inherit_configs 7 1l

let%test "zero inherit 8" =
  ["0000001l";"0b00001l";"00_0001l";"0b00001l"] =
  test_width zero_inherit_configs 8 1l

let%test "zero inherit 9" =
  ["00000001l";"0b000001l";"000_0001l";"0b0_0001l"] =
  test_width zero_inherit_configs 9 1l

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["1l";"0b1l";"1l";"0b1l"] =
  test_width left_inherit_configs 1 1l

let%test "left inherit 2" =
  ["1l";"0b1l";"1l";"0b1l"] =
  test_width left_inherit_configs 2 1l

let%test "left inherit 3" =
  [" 1l";"0b1l";" 1l";"0b1l"] =
  test_width left_inherit_configs 3 1l

let%test "left inherit 4" =
  ["  1l";"0b1l";"  1l";"0b1l"] =
  test_width left_inherit_configs 4 1l

let%test "left inherit 5" =
  ["   1l";" 0b1l";"   1l";" 0b1l"] =
  test_width left_inherit_configs 5 1l

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["1l";"0b1l";"1l";"0b1l"] =
  test_width right_inherit_configs 1 1l

let%test "right inherit 2" =
  ["1l";"0b1l";"1l";"0b1l"] =
  test_width right_inherit_configs 2 1l

let%test "right inherit 3" =
  ["1l ";"0b1l";"1l ";"0b1l"] =
  test_width right_inherit_configs 3 1l

let%test "right inherit 4" =
  ["1l  ";"0b1l";"1l  ";"0b1l"] =
  test_width right_inherit_configs 4 1l

let%test "right inherit 5" =
  ["1l   ";"0b1l ";"1l   ";"0b1l "] =
  test_width right_inherit_configs 5 1l
