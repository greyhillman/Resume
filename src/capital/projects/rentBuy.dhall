let Project = ../../types/capital/Project.dhall

let Usage = ../../types/Usage.dhall

let knowledge = ../knowledge.dhall

in  Project::{
    , title = "Rent vs. Buy Calculator"
    , link = Some "https://greyhillman.github.io/rent-vs-buy/"
    , repo = Some "https://github.com/greyhillman/rent-vs-buy"
    , purpose = "To help myself make important decision & convince others"
    , skills = [ "Learned React (with hooks) to build frontend" ]
    , knowledge =
      [ Project.used Usage.High knowledge.frameworks.react
      , Project.used Usage.High knowledge.languages.typescript
      ]
    }
