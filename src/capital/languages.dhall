let KnowledgeLevel = ../types/KnowledgeLevel.dhall

let Languages = ../types/Languages.dhall

in    { `c#` = KnowledgeLevel.Intermediate
      , html = KnowledgeLevel.Intermediate
      , css = KnowledgeLevel.Intermediate
      , less_css = KnowledgeLevel.Intermediate
      , haskell = KnowledgeLevel.Intermediate
      , js = KnowledgeLevel.Intermediate
      , type_script = KnowledgeLevel.Basic
      , python2 = KnowledgeLevel.Basic
      , python3 = KnowledgeLevel.Basic
      , dhall = KnowledgeLevel.Intermediate
      , java = KnowledgeLevel.Basic
      }
    : Languages.Type KnowledgeLevel
