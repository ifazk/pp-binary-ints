module I: Internal.S with type t = nativeint = Stdlib.Nativeint

module Dec = struct
  let prefix = "0b"
  let suffix = "n"
end

include (MakePP.Make (I) (Dec))
