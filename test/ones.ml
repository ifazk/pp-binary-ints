open Pp_binary_ints.Int

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
  "0b1" =
  to_string 1

let%test "one default manual" =
  "0b1" =
  to_string_with ~flags:default ~min_width:1 1

(** ** Zero Padding, OCaml *)

let%test "zero ocaml 1" =
  ["1";"0b1";"1";"0b1"] =
  test_width zero_ocaml_configs 1 1

let%test "zero ocaml 2" =
  ["01";"0b1";"01";"0b1"] =
  test_width zero_ocaml_configs 2 1

let%test "zero ocaml 3" =
  ["001";"0b1";"001";"0b1"] =
  test_width zero_ocaml_configs 3 1

let%test "zero ocaml 4" =
  ["0001";"0b01";"0001";"0b01"] =
  test_width zero_ocaml_configs 4 1

let%test "zero ocaml 5" =
  ["00001";"0b001";"00001";"0b001"] =
  test_width zero_ocaml_configs 5 1

let%test "zero ocaml 6" =
  ["000001";"0b0001";"0_0001";"0b0001"] =
  test_width zero_ocaml_configs 6 1

let%test "zero ocaml 7" =
  ["0000001";"0b00001";"00_0001";"0b00001"] =
  test_width zero_ocaml_configs 7 1

let%test "zero ocaml 8" =
  ["00000001";"0b000001";"000_0001";"0b0_0001"] =
  test_width zero_ocaml_configs 8 1

(** ** Left Padding, OCaml *)

let%test "left ocaml 1" =
  ["1";"0b1";"1";"0b1"] =
  test_width left_ocaml_configs 1 1

let%test "left ocaml 2" =
  [" 1";"0b1";" 1";"0b1"] =
  test_width left_ocaml_configs 2 1

let%test "left ocaml 3" =
  ["  1";"0b1";"  1";"0b1"] =
  test_width left_ocaml_configs 3 1

let%test "left ocaml 4" =
  ["   1";" 0b1";"   1";" 0b1"] =
  test_width left_ocaml_configs 4 1

let%test "left ocaml 5" =
  ["    1";"  0b1";"    1";"  0b1"] =
  test_width left_ocaml_configs 5 1

(** ** Right Padding, OCaml *)

let%test "right ocaml 1" =
  ["1";"0b1";"1";"0b1"] =
  test_width right_ocaml_configs 1 1

let%test "right ocaml 2" =
  ["1 ";"0b1";"1 ";"0b1"] =
  test_width right_ocaml_configs 2 1

let%test "right ocaml 3" =
  ["1  ";"0b1";"1  ";"0b1"] =
  test_width right_ocaml_configs 3 1

let%test "right ocaml 4" =
  ["1   ";"0b1 ";"1   ";"0b1 "] =
  test_width right_ocaml_configs 4 1

let%test "right ocaml 5" =
  ["1    ";"0b1  ";"1    ";"0b1  "] =
  test_width right_ocaml_configs 5 1

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["1";"0b1";"1";"0b1"] =
  test_width zero_inherit_configs 1 1

let%test "zero inherit 2" =
  ["01";"0b1";"01";"0b1"] =
  test_width zero_inherit_configs 2 1

let%test "zero inherit 3" =
  ["001";"0b1";"001";"0b1"] =
  test_width zero_inherit_configs 3 1

let%test "zero inherit 4" =
  ["0001";"0b01";"0001";"0b01"] =
  test_width zero_inherit_configs 4 1

let%test "zero inherit 5" =
  ["00001";"0b001";"00001";"0b001"] =
  test_width zero_inherit_configs 5 1

let%test "zero inherit 6" =
  ["000001";"0b0001";"0_0001";"0b0001"] =
  test_width zero_inherit_configs 6 1

let%test "zero inherit 7" =
  ["0000001";"0b00001";"00_0001";"0b00001"] =
  test_width zero_inherit_configs 7 1

let%test "zero inherit 8" =
  ["00000001";"0b000001";"000_0001";"0b0_0001"] =
  test_width zero_inherit_configs 8 1

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["1";"0b1";"1";"0b1"] =
  test_width left_inherit_configs 1 1

let%test "left inherit 2" =
  [" 1";"0b1";" 1";"0b1"] =
  test_width left_inherit_configs 2 1

let%test "left inherit 3" =
  ["  1";"0b1";"  1";"0b1"] =
  test_width left_inherit_configs 3 1

let%test "left inherit 4" =
  ["   1";" 0b1";"   1";" 0b1"] =
  test_width left_inherit_configs 4 1

let%test "left inherit 5" =
  ["    1";"  0b1";"    1";"  0b1"] =
  test_width left_inherit_configs 5 1

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["1";"0b1";"1";"0b1"] =
  test_width right_inherit_configs 1 1

let%test "right inherit 2" =
  ["1 ";"0b1";"1 ";"0b1"] =
  test_width right_inherit_configs 2 1

let%test "right inherit 3" =
  ["1  ";"0b1";"1  ";"0b1"] =
  test_width right_inherit_configs 3 1

let%test "right inherit 4" =
  ["1   ";"0b1 ";"1   ";"0b1 "] =
  test_width right_inherit_configs 4 1

let%test "right inherit 5" =
  ["1    ";"0b1  ";"1    ";"0b1  "] =
  test_width right_inherit_configs 5 1
