type padding =
  | Left
  | Right (* default *)
  | Zeros

type zero_printing =
  | OCaml (* depends on padding setting: bunch of zeros (no separators, no prefixs), or space padding on the left or right *)
  | InheritNonZero

type flags =
  { padding: padding
  ; separators: bool
  ; prefix_non_zero: bool
  ; zero_printing: zero_printing
  }

let default =
  { padding = Right
  ; separators =  false
  ; prefix_non_zero =  false
  ; zero_printing = OCaml
  }
