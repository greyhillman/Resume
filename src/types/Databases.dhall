let DT = \(T : Type) -> { sql_server : T, postgres : T }

in  { Type = DT
    , default =
        \(T : Type) -> \(def : T) -> { sql_server = def, postgres = def } : DT T
    , zip =
        \(T : Type) ->
        \(U : Type) ->
        \(V : Type) ->
        \(left : DT T) ->
        \(right : DT U) ->
        \(f : forall (left : T) -> forall (right : U) -> V) ->
            { sql_server = f left.sql_server right.sql_server
            , postgres = f left.postgres right.postgres
            }
          : DT V
    }
