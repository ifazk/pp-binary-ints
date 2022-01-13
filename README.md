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
- `Int.make_to_string` converts ints to strings, customizing the output with the optional arguments.
- `Int.pp_int` is a simple `Format` module style pretty printer.
- `Int.make_pp_int` is a customizable `Format` module style pretty printer with the customization controlled by the optional arguments.
- `Int.to_string_with` is a lower level function converts ints to strings, customizing the output with the `~flags` and `~min_width` named arguments.
- `Int.pp_int_with` is a lower level customizable `Format` module style pretty printer which takes in named arguments `~flags` and `~min_width`.

There are also versions available for `int32`, `int64`, and `nativeint` in the
modules
- `Int32`,
- `Int64`, and
- `Nativeint`.

A generic functor to generate binary-int printers is provided in the `MakePP`
module.

The following demonstrates using the library in a toplevel/REPL.

## Basic use

```ocaml
# #require "pp-binary-ints";;
# module Pp_Bin = Pp_binary_ints.Int;;
# Pp_Bin.to_string 0b110111;;
- : string = "0b11_0111"
# Pp_Bin.to_string 0o777;;
string = "0b1_1111_1111"
# Pp_Bin.to_string 1234;;
- : string = "0b100_1101_0010"
```

## Customizing padding and minimum width

```ocaml
# #require "pp-binary-ints";;
# module Pp_Bin = Pp_binary_ints.Int;;
# (* Space Padding *);;
# Pp_Bin.make_to_string ~zero_padding:false ~min_width:13 () 0b110111;;
- : string = "0b11_0111    "
# (* Space padding on the left is also possible *);;
# Pp_Bin.make_to_string ~zero_padding:false ~left_padding:true ~min_width:13 () 0b110111;;
- : string = "    0b11_0111"
```

## Separators and prefixes

```ocaml
# (* Turn off _ separators *);;
# Pp_Bin.make_to_string ~separators:false ~min_width:1 () 0b110111;;
- : string = "0b110111"
# (* Turn off prefixes *);;
# Pp_Bin.make_to_string ~prefix:false ~min_width:1 () 0b110111;;
- : string = "11_0111"
# (* Turn off both separatorns and prefixes *);;
# Pp_Bin.make_to_string ~separators:false ~prefix:false ~min_width:1 () 0b110111;;
- : string = "110111"
```

## Zero printing behaviour

You can ask the library to treat `0` (zero) specially and not add a prefix to
it. While it won't add a prefix to it, padding will still be added.

```ocaml
# (* Don't prefix zero *);;
# Pp_Bin.make_to_string ~zero_special:true ~min_width:1 () 0;;
- : string = "0"
# Pp_Bin.make_to_string ~zero_special:true ~min_width:1 () 0b110111;;
- : string = "0b11_0111"
(* Zero Padding still adds zeros to fill up the sapce *)
# Pp_Bin.make_to_string ~zero_special:true ~min_width:9 () 0;;
- : string = "0000_0000"
# Pp_Bin.make_to_string ~zero_special:true ~min_width:9 () 0b110111;;
- : string = "0b11_0111"
```

# Printing Binary Ints in the REPL

```ocaml
# #use "topfind";;
# #require "pp-binary-ints";;
# #install_printer Pp_binary_ints.Int.pp_int;;
# 0;;
- : int = 0b0
# 7;;
- : int = 0b111
```


You can also add the following to your `.ocamlinit` file so that integers are
always printed using this library.

```ocaml
#use "topfind";;
#require "pp-binary-ints";;
#install_printer Pp_binary_ints.Int.pp_int;;
#install_printer Pp_binary_ints.Int32.pp_int;;
#install_printer Pp_binary_ints.Int64.pp_int;;
#install_printer Pp_binary_ints.Nativeint.pp_int;;
```
