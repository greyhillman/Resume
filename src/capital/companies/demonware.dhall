let Month = ../../types/Month.dhall

let Usage = ../../types/Usage.dhall

let jobTitles = ../../common/jobTitles.dhall

let Period = ../../types/Period.dhall

let Job = ../../types/capital/Job.dhall

let knowledge = ../knowledge.dhall

let company = "Demonware"

in  Job::{
    , company
    , position = Job.position.coop "Software Developer"
    , period =
        Period.past
          { start = Period.point 2016 Month.Sep
          , end = Period.point 2016 Month.Dec
          }
    , knowledge =
      [ Job.used Usage.High knowledge.languages.python_2
      , Job.used Usage.High knowledge.tools.git
      , Job.used Usage.Low knowledge.methods.agile
      , Job.used Usage.Low knowledge.methods.scrum
      ]
    , skills =
      [ "Learned basics of software development"
      , "Participated in Agile development processes"
      ]
    }
