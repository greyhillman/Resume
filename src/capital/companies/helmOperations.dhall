let Month = ../../types/Month.dhall

let Usage = ../../types/Usage.dhall

let Period = ../../types/Period.dhall

let Job = ../../types/capital/Job.dhall

let knowledge = ../knowledge.dhall

let company = "Helm Operations"

in  { dev = Job::{
      , company
      , position = Job.position.permanent "Full-stack Developer"
      , period =
          Period.past
            { start = Period.point 2019 Month.May
            , end = Period.point 2021 Month.Jul
            }
      , knowledge =
        [ Job.used Usage.High knowledge.languages.csharp
        , Job.used Usage.Medium knowledge.languages.javascript
        , Job.used Usage.Medium knowledge.languages.html
        , Job.used Usage.Medium knowledge.languages.css
        , Job.used Usage.Medium knowledge.languages.less_css
        , Job.used Usage.High knowledge.databases.sql_server
        , Job.used Usage.Low knowledge.databases.postgres
        , Job.used Usage.Medium knowledge.frameworks.net
        , Job.used Usage.High knowledge.frameworks.knockout_js
        , Job.used Usage.Medium knowledge.frameworks.nunit
        , Job.used Usage.High knowledge.tools.visual_studio
        , Job.used Usage.High knowledge.tools.vscode
        , Job.used Usage.High knowledge.tools.git
        , Job.used Usage.High knowledge.services.jira
        , Job.used Usage.Medium knowledge.services.confluence
        , Job.used Usage.Low knowledge.languages.powershell
        , Job.used Usage.Medium knowledge.methods.agile
        , Job.used Usage.Medium knowledge.methods.scrum
        ]
      , endorsements =
        [ Job.endorsed
            "We're definitely going to miss your humour and attention to quality and detail"
            "Kathy"
            "Technical Writer"
            Job.Relation.Coworker
        , Job.endorsed
            "I'm gonna miss your attention to all the high-level problems in our code"
            "Tim"
            "Full-stack Developer"
            Job.Relation.Coworker
        , Job.endorsed
            "Talented dev with well-though-out solutions and attention to good coding practices"
            "Peter"
            "Team Lead"
            Job.Relation.Boss
        ]
      , skills =
        [ "Continual advocate for best practises across code, UI/UX, processes"
        , "Fixed several core issues within first year to recover system from major outage"
        , "Oversaw 2 testing infrastructure projects from conception to completion"
        ]
      }
    , coop =
          Job::{
          , company
          , position = Job.position.coop "Software Developer"
          , period =
              Period.past
                { start = Period.point 2019 Month.Jan
                , end = Period.point 2019 Month.Apr
                }
          , knowledge =
            [ Job.used Usage.High knowledge.languages.csharp
            , Job.used Usage.Medium knowledge.languages.javascript
            , Job.used Usage.Medium knowledge.languages.html
            , Job.used Usage.Medium knowledge.languages.less_css
            , Job.used Usage.Medium knowledge.languages.css
            , Job.used Usage.Medium knowledge.databases.sql_server
            , Job.used Usage.High knowledge.frameworks.knockout_js
            , Job.used Usage.Low knowledge.frameworks.net
            , Job.used Usage.Medium knowledge.tools.visual_studio
            , Job.used Usage.High knowledge.tools.vscode
            , Job.used Usage.Low knowledge.services.jira
            , Job.used Usage.Low knowledge.services.confluence
            ]
          }
        : Job.Type
    }
