module I: Internal.S with type t = int32 = Stdlib.Int32

module Dec = struct
  let prefix = "0b"
  let suffix = "l"
end

include (MakePP.Make (I) (Dec))
