let Month = ../../types/Month.dhall

let Usage = ../../types/Usage.dhall

let jobTitles = ../../common/jobTitles.dhall

let Period = ../../types/Period.dhall

let Job = ../../types/capital/Job.dhall

let knowledge = ../knowledge.dhall

let company = "Latitude Geographics"

in  Job::{
    , company
    , position = Job.position.coop "Quality Assurance Analyst"
    , period =
        Period.past
          { start = Period.point 2018 Month.May
          , end = Period.point 2018 Month.Aug
          }
    , knowledge =
      [ Job.used Usage.High knowledge.languages.typescript
      , Job.used Usage.High knowledge.frameworks.web_driver
      , Job.used Usage.High knowledge.tools.vscode
      ]
    , skills =
      [ "Gave recommendations on design of end-to-end tests (\"model\"-based)"
      , "Introduced tool to improve QA reports"
      , "Developed TypeScript automated end-to-end tests for new product"
      ]
    }
