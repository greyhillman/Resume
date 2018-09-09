let KnowledgeLevel = ../types/KnowledgeLevel.dhall

let Methodologies = ../types/Methodologies.dhall

in    { agile = KnowledgeLevel.Intermediate
      , scrum = KnowledgeLevel.Intermediate
      }
    : Methodologies.Type KnowledgeLevel
