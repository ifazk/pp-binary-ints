(lang dune 2.9)
(name pp-binary-ints)

(generate_opam_files true)
(license CC0-1.0)
(authors "Ifaz Kabir")
(maintainers "Ifaz Kabir")
(source (github ifazk/pp-binary-ints))
(documentation https://ifazk.github.io/pp-binary-ints/)
(version 1.0.0)

(package
 (name pp-binary-ints)
 (synopsis "Pretty Printing Binary Integers")
 (description
   "\| Pretty Printing Binary Integers
   "\| This library contains functions for pretty printing integers as
   "\| unsigned binary integers.
 )
 (tags ("printf" "format" "boolean" "binary"))
 (depends (ocaml (>= 4.10)) (ppx_inline_test :with-test)))
