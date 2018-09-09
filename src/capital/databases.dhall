let KnowledgeLevel = ../types/KnowledgeLevel.dhall

let Databases = ../types/Databases.dhall

in    { sql_server = KnowledgeLevel.Basic, postgres = KnowledgeLevel.Basic }
    : Databases.Type KnowledgeLevel
