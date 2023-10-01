let Project = ../../types/capital/Project.dhall

let Usage = ../../types/Usage.dhall

let knowledge = ../knowledge.dhall

in  Project::{
    , title = "Resume"
    , repo = Some "https://github.com/greyhillman/Resume"
    , purpose = "To hold all resume data; change resume quickly & easily"
    , skills = [ "Learned Dhall to hold data & configure content" ]
    , knowledge =
      [ Project.used Usage.High knowledge.languages.dhall
      , Project.used Usage.Medium knowledge.languages.csharp
      ]
    }
