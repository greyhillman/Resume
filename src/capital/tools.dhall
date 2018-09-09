let KnowledgeLevel = ../types/KnowledgeLevel.dhall

let Tools = ../types/Tools.dhall

in    { git = KnowledgeLevel.Intermediate
      , vim = KnowledgeLevel.Basic
      , vs_code = KnowledgeLevel.Intermediate
      , visual_studio = KnowledgeLevel.Basic
      , jira = KnowledgeLevel.Intermediate
      , confluence = KnowledgeLevel.Intermediate
      , powershell = KnowledgeLevel.Basic
      , tmux = KnowledgeLevel.Basic
      }
    : Tools.Type KnowledgeLevel
