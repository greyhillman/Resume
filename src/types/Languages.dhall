let Languages =
      \(T : Type) ->
        { `c#` : T
        , html : T
        , css : T
        , less_css : T
        , haskell : T
        , js : T
        , type_script : T
        , python2 : T
        , python3 : T
        , dhall : T
        , java : T
        }

in  { Type = Languages
    , default =
        \(T : Type) ->
        \(def : T) ->
            { `c#` = def
            , html = def
            , css = def
            , less_css = def
            , haskell = def
            , js = def
            , type_script = def
            , python2 = def
            , python3 = def
            , dhall = def
            , java = def
            }
          : Languages T
    , zip =
        \(T : Type) ->
        \(U : Type) ->
        \(V : Type) ->
        \(left : Languages T) ->
        \(right : Languages U) ->
        \(f : forall (left : T) -> forall (right : U) -> V) ->
            { `c#` = f left.`c#` right.`c#`
            , html = f left.html right.html
            , css = f left.css right.css
            , less_css = f left.less_css right.less_css
            , haskell = f left.haskell right.haskell
            , js = f left.js right.js
            , type_script = f left.type_script right.type_script
            , python2 = f left.python2 right.python2
            , python3 = f left.python3 right.python3
            , dhall = f left.dhall right.dhall
            , java = f left.java right.java
            }
          : Languages V
    }
