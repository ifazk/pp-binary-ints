# pp-binary-ints

An OCaml library for printing `int`s as unsigned binary integers.

The pretty printers are fairly customizable. The following options are supported.

- Padding with zeros or spaces so that binary integers satisfy a minimum width.
- Prefixing the integers `0b`.
- Separating every four bits with `_` (underscore).
- Choose if zeros should be printed similar to non-zero ints.

You can find documentation for the library [here](https://ifazk.github.io/pp-binary-ints/).

# Installation
Install this library using `opam`.

```
opam install pp-binary-ints
```

# Examples

The library provides four main functions.

- `Int.to_string` converts ints to strings.
- `Int.to_string_with ~flags ~min_width` converts ints to strings, customizing the output with `flags` and `min_width`.
- `Int.pp_int` is a simple `Format` module style pretty printer.
- `Int.pp_binary_int ~flags ~min_width` is a customizable `Format` module style pretty printer.

There are also versions available for `int32`, `int64`, and `nativeint` in the
modules
- `Int32`,
- `Int64`, and
- `Nativeint`.

A generic functor to generate binary-int printers is provided in the `MakePP`
module.

## Basic use

```ocaml
# #require "pp-binary-ints";;
# module Pp_Bin = Pp_binary_ints.Int;;
# Pp_Bin.to_string 0b110111;;
- : string = "110111"
# Pp_Bin.to_string 0o777;;
- : string = "111111111"
# Pp_Bin.to_string 1234;;
- : string = "10011010010"
```

## Customizing padding and minimum width

```ocaml
# #require "pp-binary-ints";;
# module Pp_Bin = Pp_binary_ints.Int;;
# (* Zero Padding *);;
# Pp_Bin.to_string_with ~flags:Pp_Bin.Flags.{ default with padding = Zeros } ~min_width:13 0b110111;;
- : string = "0000000110111"
# (* Default is space padding on the right *);;
# Pp_Bin.to_string_with ~flags:Pp_Bin.Flags.default ~min_width:13 0b110111;;
- : string = "110111       "
# (* Space padding on the left is also possible *);;
# Pp_Bin.to_string_with ~flags:Pp_Bin.Flags.{ default with padding = Left} ~min_width:13 0b110111;;
- : string = "       110111"
```

## Separators and prefixes

```ocaml
# (* Separate every 4 digits with _ *);;
# Pp_Bin.to_string_with ~flags:Pp_Bin.Flags.{ default with separators = true } ~min_width:1 0b110111;;
- : string = "11_0111"
# (* Prefix non-zero *);;
# Pp_Bin.to_string_with ~flags:Pp_Bin.Flags.{ default with prefix_non_zero = true } ~min_width:1 0b110111;;
- : string = "0b110111"
# (* Prefix non-zero with separators *);;
# Pp_Bin.to_string_with ~flags:Pp_Bin.Flags.{ default with prefix_non_zero = true; separators = true } ~min_width:1 0b110111;;
- : string = "0b11_0111"
```

## Zero printing behaviour

We support pretty printing `0` (zero) both how OCaml's `Printf` woould print it,
as well as printing it similar to how we print non zero integers. The default
behaviour is to follow `Printf`'s zero printing and not print a prefix, but this
can be changed by setting the `zero_printing` flag to `InheritNonZero`.

```ocaml
# (* Prefix's are not added to zero by default *);;
# Pp_Bin.to_string_with ~flags:Pp_Bin.Flags.{ default with prefix_non_zero = true } ~min_width:1 0;;
- : string = "0"
# Pp_Bin.to_string_with ~flags:Pp_Bin.Flags.{ default with prefix_non_zero = true; zero_printing = InheritNonZero } ~min_width:1 0;;
- : string = "0b0"
# (* All the above options can be combined *);;
# Pp_Bin.to_string_with ~flags:Pp_Bin.Flags.{ padding = Zeros; separators = true; prefix_non_zero = true; zero_printing = InheritNonZero } ~min_width:8 0;;
- : string = "0b0_0000"
# (* The library is careful not to write "0b_" when prefixing, 'b' is always followed by a digit *);;
# Pp_Bin.to_string_with ~flags:Pp_Bin.Flags.{ padding = Zeros; separators = true; prefix_non_zero = true; zero_printing = InheritNonZero } ~min_width:7 0;;
- : string = "0b00000"
```
