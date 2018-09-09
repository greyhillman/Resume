let M = \(T : Type) -> { agile : T, scrum : T }

in  { Type = M
    , default = \(T : Type) -> \(def : T) -> { agile = def, scrum = def } : M T
    , zip =
        \(T : Type) ->
        \(U : Type) ->
        \(V : Type) ->
        \(left : M T) ->
        \(right : M U) ->
        \(f : forall (left : T) -> forall (right : U) -> V) ->
            { agile = f left.agile right.agile
            , scrum = f left.scrum right.scrum
            }
          : M V
    }
