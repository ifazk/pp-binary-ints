module I: Internal.S with type t = int64 = Stdlib.Int64

module Dec = struct
  let prefix = "0b"
  let suffix = "L"
end

include (MakePP.Make (I) (Dec))
