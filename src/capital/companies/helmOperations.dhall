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

let jobLanguages =
      Job.Languages::{
      , `c#` = Usage.High
      , js = Usage.Medium
      , html = Usage.Medium
      , css = Usage.Medium
      , less_css = Usage.Medium
      }

let fulltime_dev =
        Job::{
        , title = jobTitles.fullStackDev
        , period =
            Period.Long
              { start = { month = Month.May, year = 2019 }
              , end = { month = Month.Jul, year = 2021 }
              }
        , languages = jobLanguages
        , databases = Job.Databases::{
          , sql_server = Usage.High
          , postgres = Usage.Low
          }
        , frameworks = Job.Frameworks::{
          , net = Usage.Medium
          , knockout = Usage.High
          , nunit = Usage.Medium
          }
        , tools = Job.Tools::{
          , visual_studio = Usage.High
          , vs_code = Usage.High
          , git = Usage.High
          , jira = Usage.High
          , confluence = Usage.Medium
          , powershell = Usage.Low
          }
        , methodologies = Job.Methodologies::{
          , agile = Usage.Medium
          , scrum = Usage.Medium
          }
        }
      : Job.Type

in  { company = "Helm Operations"
    , positions =
      { dev =
              fulltime_dev
          /\  { highlights =
                { bestPractisesAdvocate =
                    "Continual advocate for best practises across code, UI/UX, processes"
                , quickLearner =
                    "Fixed several core issues within first year to recover system from major outage"
                , testInfra =
                    "Oversaw 2 testing infrastructure projects from conception to completion"
                }
              , quotes =
                { kathy =
                    "We're definitely going to miss your humour and attention to quality and detail"
                , tim =
                    "I'm gonna miss your attention to all the high-level problems in our code"
                , peter =
                    "Talented dev with well-thought-out solutions and attention to good coding practices"
                }
              }
      , coop =
            Job::{
            , title = jobTitles.coop jobTitles.fullStackDev
            , period =
                Period.Short { year = 2019, start = Month.Jan, end = Month.Apr }
            , languages = jobLanguages
            , databases = Job.Databases::{ sql_server = Usage.Medium }
            , frameworks = Job.Frameworks::{
              , net = Usage.Low
              , knockout = Usage.High
              }
            , tools = Job.Tools::{
              , visual_studio = Usage.Medium
              , vs_code = Usage.High
              , jira = Usage.Low
              , confluence = Usage.Low
              }
            }
          : Job.Type
      }
    }
