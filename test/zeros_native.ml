open Pp_binary_ints.Nativeint

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
  "0b0n" =
  to_string 0n

let%test "zero default manual" =
  "0b0n" =
  to_string_with ~flags:default ~min_width:1 0n

(** ** Zero Padding, OCaml *)

(** OCaml's [Printf] does not prefix zeros *)

let%test "zero ocaml 1" =
  ["0n";"0n";"0n";"0n"] =
  test_width zero_ocaml_configs 1 0n

let%test "zero ocaml 2" =
  ["0n";"0n";"0n";"0n"] =
  test_width zero_ocaml_configs 2 0n

let%test "zero ocaml 3" =
  ["00n";"00n";"00n";"00n"] =
  test_width zero_ocaml_configs 3 0n

let%test "zero ocaml 4" =
  ["000n";"000n";"000n";"000n"] =
  test_width zero_ocaml_configs 4 0n

let%test "zero ocaml 5" =
  ["0000n";"0000n";"0000n";"0000n"] =
  test_width zero_ocaml_configs 5 0n

let%test "zero ocaml 6" =
  ["00000n";"00000n";"00000n";"00000n"] =
  test_width zero_ocaml_configs 6 0n

let%test "zero ocaml 7" =
  ["000000n";"000000n";"0_0000n";"0_0000n"] =
  test_width zero_ocaml_configs 7 0n

let%test "zero ocaml 16" =
  ["000000000000000n"
  ;"000000000000000n"
  ;"00000_0000_0000n"
  ;"00000_0000_0000n"
  ] =
  test_width zero_ocaml_configs 16 0n

let%test "zero ocaml 17" =
  ["0000000000000000n"
  ;"0000000000000000n"
  ;"0_0000_0000_0000n"
  ;"0_0000_0000_0000n"
  ] =
  test_width zero_ocaml_configs 17 0n

(** ** Left Padding, OCaml *)

let%test "left ocaml 1" =
  ["0n";"0n";"0n";"0n"] =
  test_width left_ocaml_configs 1 0n

let%test "left ocaml 2" =
  ["0n";"0n";"0n";"0n"] =
  test_width left_ocaml_configs 2 0n

let%test "left ocaml 3" =
  [" 0n";" 0n";" 0n";" 0n"] =
  test_width left_ocaml_configs 3 0n

let%test "left ocaml 4" =
  ["  0n";"  0n";"  0n";"  0n"] =
  test_width left_ocaml_configs 4 0n

let%test "left ocaml 5" =
  ["   0n";"   0n";"   0n";"   0n"] =
  test_width left_ocaml_configs 5 0n

(** ** Right Padding, OCaml *)

let%test "right ocaml 1" =
  ["0n";"0n";"0n";"0n"] =
  test_width right_ocaml_configs 1 0n

let%test "right ocaml 2" =
  ["0n";"0n";"0n";"0n"] =
  test_width right_ocaml_configs 2 0n

let%test "right ocaml 3" =
  ["0n ";"0n ";"0n ";"0n "] =
  test_width right_ocaml_configs 3 0n

let%test "right ocaml 4" =
  ["0n  ";"0n  ";"0n  ";"0n  "] =
  test_width right_ocaml_configs 4 0n

let%test "right ocaml 5" =
  ["0n   ";"0n   ";"0n   ";"0n   "] =
  test_width right_ocaml_configs 5 0n

(** ** Zero Padding, Inherit *)

let%test "zero inherit 1" =
  ["0n";"0b0n";"0n";"0b0n"] =
  test_width zero_inherit_configs 1 0n

let%test "zero inherit 2" =
  ["0n";"0b0n";"0n";"0b0n"] =
  test_width zero_inherit_configs 2 0n

let%test "zero inherit 3" =
  ["00n";"0b0n";"00n";"0b0n"] =
  test_width zero_inherit_configs 3 0n

let%test "zero inherit 4" =
  ["000n";"0b0n";"000n";"0b0n"] =
  test_width zero_inherit_configs 4 0n

let%test "zero inherit 5" =
  ["0000n";"0b00n";"0000n";"0b00n"] =
  test_width zero_inherit_configs 5 0n

let%test "zero inherit 6" =
  ["00000n";"0b000n";"00000n";"0b000n"] =
  test_width zero_inherit_configs 6 0n

let%test "zero inherit 7" =
  ["000000n";"0b0000n";"0_0000n";"0b0000n"] =
  test_width zero_inherit_configs 7 0n

let%test "zero inherit 8" =
  ["0000000n";"0b00000n";"00_0000n";"0b00000n"] =
  test_width zero_inherit_configs 8 0n

let%test "zero inherit 9" =
  ["00000000n";"0b000000n";"000_0000n";"0b0_0000n"] =
  test_width zero_inherit_configs 9 0n

let%test "zero inherit 16" =
  ["000000000000000n"
  ;"0b0000000000000n"
  ;"00000_0000_0000n"
  ;"0b000_0000_0000n"
  ] =
  test_width zero_inherit_configs 16 0n

(** ** Left Padding, Inherit *)

let%test "left inherit 1" =
  ["0n";"0b0n";"0n";"0b0n"] =
  test_width left_inherit_configs 1 0n

let%test "left inherit 2" =
  ["0n";"0b0n";"0n";"0b0n"] =
  test_width left_inherit_configs 2 0n

let%test "left inherit 3" =
  [" 0n";"0b0n";" 0n";"0b0n"] =
  test_width left_inherit_configs 3 0n

let%test "left inherit 4" =
  ["  0n";"0b0n";"  0n";"0b0n"] =
  test_width left_inherit_configs 4 0n

let%test "left inherit 5" =
  ["   0n";" 0b0n";"   0n";" 0b0n"] =
  test_width left_inherit_configs 5 0n

(** ** Right Padding, Inherit *)

let%test "right inherit 1" =
  ["0n";"0b0n";"0n";"0b0n"] =
  test_width right_inherit_configs 1 0n

let%test "right inherit 2" =
  ["0n";"0b0n";"0n";"0b0n"] =
  test_width right_inherit_configs 2 0n

let%test "right inherit 3" =
  ["0n ";"0b0n";"0n ";"0b0n"] =
  test_width right_inherit_configs 3 0n

let%test "right inherit 4" =
  ["0n  ";"0b0n";"0n  ";"0b0n"] =
  test_width right_inherit_configs 4 0n

let%test "right inherit 5" =
  ["0n   ";"0b0n ";"0n   ";"0b0n "] =
  test_width right_inherit_configs 5 0n
