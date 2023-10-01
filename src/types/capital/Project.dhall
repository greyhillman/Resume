let KnowledgeUsage = ./Job/KnowledgeUsage.dhall

let Usage = ../../types/Usage.dhall

let Project =
      { title : Text
      , link : Optional Text
      , repo : Optional Text
      , purpose : Text
      , skills : List Text
      , knowledge : List KnowledgeUsage
      }

in  { Type = Project
    , default =
      { skills = [] : List Text
      , knowledge = [] : List KnowledgeUsage
      , link = None Text
      , repo = None Text
      }
    , used =
        \(usage : Usage) ->
        \(knowledge : Text) ->
          { usage, knowledge } : KnowledgeUsage
    }
