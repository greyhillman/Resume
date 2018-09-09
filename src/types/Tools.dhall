let TT =
      \(T : Type) ->
        { vim : T
        , tmux : T
        , visual_studio : T
        , git : T
        , vs_code : T
        , jira : T
        , confluence : T
        , powershell : T
        }

in  { Type = TT
    , default =
        \(T : Type) ->
        \(def : T) ->
            { vim = def
            , tmux = def
            , visual_studio = def
            , git = def
            , vs_code = def
            , jira = def
            , confluence = def
            , powershell = def
            }
          : TT T
    , zip =
        \(T : Type) ->
        \(U : Type) ->
        \(V : Type) ->
        \(left : TT T) ->
        \(right : TT U) ->
        \(f : forall (left : T) -> forall (right : U) -> V) ->
            { vim = f left.vim right.vim
            , tmux = f left.tmux right.tmux
            , visual_studio = f left.visual_studio right.visual_studio
            , git = f left.git right.git
            , vs_code = f left.vs_code right.vs_code
            , jira = f left.jira right.jira
            , confluence = f left.confluence right.confluence
            , powershell = f left.powershell right.powershell
            }
          : TT V
    }
