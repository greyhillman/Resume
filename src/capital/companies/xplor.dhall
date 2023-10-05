let Month = ../../types/Month.dhall

let Usage = ../../types/Usage.dhall

let knowledge = ../knowledge.dhall

let Period = ../../types/Period.dhall

let Job = ../../types/capital/Job.dhall

let company = "Xplor"

in  { junior = Job::{
      , company
      , position = Job.position.permanent "Junior Software Developer"
      , period =
          Period.past
            { start = Period.point 2022 Month.Apr
            , end = Period.point 2023 Month.May
            }
      , knowledge =
        [ Job.used Usage.High knowledge.languages.csharp
        , Job.used Usage.High knowledge.services.aws
        , Job.used Usage.High knowledge.frameworks.asp_net_mvc
        , Job.used Usage.Medium knowledge.languages.html
        , Job.used Usage.Medium knowledge.languages.scss
        , Job.used Usage.Medium knowledge.services.jira
        , Job.used Usage.Medium knowledge.databases.dynamo_db
        ]
      , skills =
        [ "Identified \$35k/year in AWS savings for ECS clusters"
        , "Migrated internal tool's AWS infrastructure to Terraform"
        , "Designed, built, and maintained AWS systems for internal tool"
        , "Trained co-op on software development basics"
        , "Planned migration of Bamboo builds and deployments to Bamboo Specs"
        , "Used previous knowledge of Dhall for Bamboo Specs"
        , "Learned AWS via Udemy and applied learning immediately"
        ]
      }
    , intermediate = Job::{
      , company
      , position = Job.position.permanent "Intermediate Software Developer"
      , period = Period.current 2023 Month.May
      , knowledge =
        [ Job.used Usage.Medium knowledge.languages.dhall
        , Job.used Usage.High knowledge.frameworks.terraform
        , Job.used Usage.High knowledge.services.bamboo
        , Job.used Usage.High knowledge.services.aws
        ]
      , skills =
        [ "Worked on migrating production AWS infrastructure to Terraform"
        , "Debugging AWS infrastructure"
        ]
      }
    }
