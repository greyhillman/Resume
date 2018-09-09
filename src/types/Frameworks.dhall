let FT =
      \(value_type : Type) ->
        { net : value_type
        , knockout : value_type
        , react : value_type
        , vue : value_type
        , nunit : value_type
        }

in  { Type = FT
    , default =
        \(T : Type) ->
        \(def : T) ->
            { net = def, knockout = def, react = def, vue = def, nunit = def }
          : FT T
    , zip =
        \(T : Type) ->
        \(U : Type) ->
        \(V : Type) ->
        \(left : FT T) ->
        \(right : FT U) ->
        \(f : forall (left : T) -> forall (right : U) -> V) ->
            { net = f left.net right.net
            , knockout = f left.knockout right.knockout
            , react = f left.react right.react
            , vue = f left.vue right.vue
            , nunit = f left.nunit right.nunit
            }
          : FT V
    }
