module Int: MakePP.S with type t = int = Stdlib.Int

module Dec = struct
  let prefix = "0b"
  let suffix = ""
end

module Flags = Flags

include (MakePP.Make (Int) (Dec))
