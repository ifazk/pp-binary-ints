open Pp_binary_ints.Int

open Flags

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
  "0" =
  to_string 0

let%test "zero default manual" =
  "0" =
  to_string_with ~flags:default ~min_width:1 0

(** ** Zero Padding, OCaml *)

(** OCaml's [Printf] does not prefix zeros *)

let%test "zero ocaml 1" =
  ["0";"0";"0";"0"] =
  test_width zero_ocaml_configs 1 0

let%test "zero ocaml 2" =
  ["00";"00";"00";"00"] =
  test_width zero_ocaml_configs 2 0

let%test "zero ocaml 3" =
  ["000";"000";"000";"000"] =
  test_width zero_ocaml_configs 3 0

let%test "zero ocaml 4" =
  ["0000";"0000";"0000";"0000"] =
  test_width zero_ocaml_configs 4 0

let%test "zero ocaml 5" =
  ["00000";"00000";"00000";"00000"] =
  test_width zero_ocaml_configs 5 0

let%test "zero ocaml 6" =
  ["000000";"000000";"0_0000";"0_0000"] =
  test_width zero_ocaml_configs 6 0

let%test "zero ocaml 16" =
  ["0000000000000000"
  ;"0000000000000000"
  ;"0_0000_0000_0000"
  ;"0_0000_0000_0000"
  ] =
  test_width zero_ocaml_configs 16 0

(** ** Left Padding, OCaml *)

let%test "left ocaml 1" =
  ["0";"0";"0";"0"] =
  test_width left_ocaml_configs 1 0

let%test "left ocaml 2" =
  [" 0";" 0";" 0";" 0"] =
  test_width left_ocaml_configs 2 0

let%test "left ocaml 3" =
  ["  0";"  0";"  0";"  0"] =
  test_width left_ocaml_configs 3 0

let%test "left ocaml 4" =
  ["   0";"   0";"   0";"   0"] =
  test_width left_ocaml_configs 4 0

let%test "left ocaml 5" =
  ["    0";"    0";"    0";"    0"] =
  test_width left_ocaml_configs 5 0

(** ** Right Padding, OCaml *)

let%test "right ocaml 1" =
  ["0";"0";"0";"0"] =
  test_width right_ocaml_configs 1 0

let%test "right ocaml 2" =
  ["0 ";"0 ";"0 ";"0 "] =
  test_width right_ocaml_configs 2 0

let%test "right ocaml 3" =
  ["0  ";"0  ";"0  ";"0  "] =
  test_width right_ocaml_configs 3 0

let%test "right ocaml 4" =
  ["0   ";"0   ";"0   ";"0   "] =
  test_width right_ocaml_configs 4 0

let%test "right ocaml 5" =
  ["0    ";"0    ";"0    ";"0    "] =
  test_width right_ocaml_configs 5 0

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["0";"0b0";"0";"0b0"] =
  test_width zero_inherit_configs 1 0

let%test "zero inherit 2" =
  ["00";"0b0";"00";"0b0"] =
  test_width zero_inherit_configs 2 0

let%test "zero inherit 3" =
  ["000";"0b0";"000";"0b0"] =
  test_width zero_inherit_configs 3 0

let%test "zero inherit 4" =
  ["0000";"0b00";"0000";"0b00"] =
  test_width zero_inherit_configs 4 0

let%test "zero inherit 5" =
  ["00000";"0b000";"00000";"0b000"] =
  test_width zero_inherit_configs 5 0

let%test "zero inherit 6" =
  ["000000";"0b0000";"0_0000";"0b0000"] =
  test_width zero_inherit_configs 6 0

let%test "zero inherit 7" =
  ["0000000";"0b00000";"00_0000";"0b00000"] =
  test_width zero_inherit_configs 7 0

let%test "zero inherit 8" =
  ["00000000";"0b000000";"000_0000";"0b0_0000"] =
  test_width zero_inherit_configs 8 0

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["0";"0b0";"0";"0b0"] =
  test_width left_inherit_configs 1 0

let%test "left inherit 2" =
  [" 0";"0b0";" 0";"0b0"] =
  test_width left_inherit_configs 2 0

let%test "left inherit 3" =
  ["  0";"0b0";"  0";"0b0"] =
  test_width left_inherit_configs 3 0

let%test "left inherit 4" =
  ["   0";" 0b0";"   0";" 0b0"] =
  test_width left_inherit_configs 4 0

let%test "left inherit 5" =
  ["    0";"  0b0";"    0";"  0b0"] =
  test_width left_inherit_configs 5 0

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["0";"0b0";"0";"0b0"] =
  test_width right_inherit_configs 1 0

let%test "right inherit 2" =
  ["0 ";"0b0";"0 ";"0b0"] =
  test_width right_inherit_configs 2 0

let%test "right inherit 3" =
  ["0  ";"0b0";"0  ";"0b0"] =
  test_width right_inherit_configs 3 0

let%test "right inherit 4" =
  ["0   ";"0b0 ";"0   ";"0b0 "] =
  test_width right_inherit_configs 4 0

let%test "right inherit 5" =
  ["0    ";"0b0  ";"0    ";"0b0  "] =
  test_width right_inherit_configs 5 0
