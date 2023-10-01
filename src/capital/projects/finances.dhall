let Project = ../../types/capital/Project.dhall

let Usage = ../../types/Usage.dhall

let knowledge = ../knowledge.dhall

in  Project::{
    , title = "Personal Finances System"
    , purpose =
        "To track personal finances; automatically produce financial reports"
    , skills =
      [ "Used Haskell's Shake build system to generate reports"
      , "Learned Dhall to store financial data"
      ]
    , knowledge =
      [ Project.used Usage.High knowledge.languages.dhall
      , Project.used Usage.Medium knowledge.languages.csharp
      ]
    }
