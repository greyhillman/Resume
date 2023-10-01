let Month = ../../types/Month.dhall

let Usage = ../../types/Usage.dhall

let Period = ../../types/Period.dhall

let Job = ../../types/capital/Job.dhall

let knowledge = ../knowledge.dhall

let company = "UVic Civil Engineering"

in  Job::{
    , company
    , position = Job.position.coop "Software Developer"
    , period =
        Period.past
          { start = Period.point 2017 Month.May
          , end = Period.point 2017 Month.Aug
          }
    , knowledge =
      [ Job.used Usage.High knowledge.languages.python_3
      , Job.used Usage.Low knowledge.frameworks.docker
      , Job.used Usage.High knowledge.tools.vscode
      ]
    , skills =
      [ "Refactored researcher's code to allow for future development (also fixed critical issue)"
      , "Explained technical concepts to non-technical people"
      ]
    , endorsements =
      [ Job.endorsed
          "Good at explaining technical concepts to non-technical people"
          "Ralph"
          "Professor/Head Researcher"
          Job.Relation.Boss
      ]
    }
