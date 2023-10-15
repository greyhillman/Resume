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
      , "Migrated to .NET due to limitations in hledger"
      , "Created new accounting Nuget packages based on hledger"
      , "Created new build system in .NET based on Haskell's Shake library"
      ]
    , knowledge =
      [ Project.used Usage.High knowledge.languages.dhall
      , Project.used Usage.High knowledge.languages.csharp
      , Project.used Usage.High knowledge.frameworks.net_7
      ]
    }
