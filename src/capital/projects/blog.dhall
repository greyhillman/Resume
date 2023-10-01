let Project = ../../types/capital/Project.dhall

let Usage = ../../types/Usage.dhall

let knowledge = ../knowledge.dhall

in  Project::{
    , title = "Personal Blog"
    , link = Some "https://greyhillman.github.io/"
    , repo = Some "https://github.com/greyhillman/greyhillman.github.io"
    , purpose = "To explain my ideas; teach others via explorable explanations"
    }
