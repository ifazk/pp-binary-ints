type padding =
  | Left
  | Right (* default *)
  | Zeros

type zero_printing =
  | OCaml (* depends on padding setting: no prefixes for zero padding, or space padding on the left or right *)
  | InheritNonZero

type flags =
  { padding: padding
  ; separators: bool
  ; prefix_non_zero: bool
  ; suffix : bool
  ; zero_printing: zero_printing
  }

let default =
  { padding = Zeros
  ; separators =  true
  ; prefix_non_zero = true
  ; suffix = true
  ; zero_printing = InheritNonZero
  }

let make_flags ?(zero_padding = true) ?(left_padding=false) ?(separators=true)
    ?(prefix=true) ?(suffix=true) ?(zero_special=false) () =
  let padding = if zero_padding then Zeros else (if left_padding then Left else Right) in
  let prefix_non_zero = prefix in
  let zero_printing = if zero_special then OCaml else InheritNonZero in
  { padding; separators; prefix_non_zero; suffix; zero_printing }
