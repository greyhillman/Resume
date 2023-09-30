let Month = ../../types/Month.dhall

let databases = ../../common/databases.dhall

let frameworks = ../../common/frameworks.dhall

let languages = ../../common/languages.dhall

let tools = ../../common/tools.dhall

let methodologies = ../../common/methodologies.dhall

let jobTitles = ../../common/jobTitles.dhall

let JobLanguage = ../../types/capital/JobLanguage.dhall

let Usage = ../../types/Usage.dhall

let Period = ../../types/Period.dhall

let Job = ../../types/capital/JobPosition.dhall

in  { company = "Xplor"
    , positions =
      { junior =
              Job::{
              , title = "Junior Software Developer"
              , period =
                  Period.past
                    { start = Period.point 2022 Month.Apr
                    , end = Period.point 2023 Month.May
                    }
              }
          /\  { highlights = {=}, quotes = {=} }
      , intermediate =
              Job::{
              , title = "Intermediate Software Developer"
              , period = Period.current 2023 Month.May
              , languages = Job.Languages::{=}
              , databases = Job.Databases::{ sql_server = Usage.Low }
              , frameworks = Job.Frameworks::{ net = Usage.High }
              , tools = Job.Tools::{
                , visual_studio = Usage.High
                , vs_code = Usage.High
                , jira = Usage.Medium
                , confluence = Usage.Low
                }
              }
          /\  { highlights = {=}, quotes = {=} }
      }
    }
