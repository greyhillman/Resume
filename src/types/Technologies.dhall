let TT =
      \(value_type : Type) ->
        { web_driver_io : value_type, docker : value_type }

in  { Type = TT
    , default =
        \(T : Type) ->
        \(def : T) ->
          { web_driver_io = def, docker = def } : TT T
    , zip =
        \(T : Type) ->
        \(U : Type) ->
        \(V : Type) ->
        \(left : TT T) ->
        \(right : TT U) ->
        \(f : forall (left : T) -> forall (right : U) -> V) ->
            { web_driver_io = f left.web_driver_io right.web_driver_io
            , docker = f left.docker right.docker
            }
          : TT V
    }
