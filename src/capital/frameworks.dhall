let KnowledgeLevel = ../types/KnowledgeLevel.dhall

let Frameworks = ../types/Frameworks.dhall

in    { react = KnowledgeLevel.Intermediate
      , vue = KnowledgeLevel.Basic
      , net = KnowledgeLevel.Basic
      , knockout = KnowledgeLevel.Intermediate
      , nunit = KnowledgeLevel.Intermediate
      }
    : Frameworks.Type KnowledgeLevel
