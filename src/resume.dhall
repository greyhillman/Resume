let Resume = ./types/Resume.dhall

let Period = ./types/Period.dhall

let Month = ./types/Month.dhall

let Capital = ./types/capital/package.dhall

let capital = ./capital/package.dhall

let jobs = capital.experience.jobs

let projects = capital.experience.projects

let knowledge = ./capital/knowledge.dhall

let Endorsement = Capital.Experience.Job.Endorsement

let position_title =
      \(position : Capital.Experience.Job.Position) ->
        let suffix =
              merge { Coop = " (Co-op)", Permanent = "" } position.contract

        in  "${position.title}${suffix}"

let show_month =
      \(month : Month) ->
        merge
          { Jan = "Jan"
          , Feb = "Feb"
          , Mar = "Mar"
          , Apr = "Apr"
          , May = "May"
          , Jun = "Jun"
          , Jul = "Jul"
          , Aug = "Aug"
          , Sep = "Sep"
          , Oct = "Oct"
          , Nov = "Nov"
          , Dec = "Dec"
          }
          month

let long_period =
      \(period : Period.Type) ->
        let show_point =
              \(point : Period.Point) ->
                "${show_month point.month} ${Natural/show point.year}"

        in  merge
              { Current =
                  \(current : Period.Current) -> "${show_point current.start} -"
              , Past =
                  \(past : Period.Past) ->
                    "${show_point past.start} - ${show_point past.end}"
              }
              period

let short_period =
      \(period : Period.Type) ->
        let show_point =
              \(point : Period.Point) ->
                "${show_month point.month} ${Natural/show point.year}"

        in  merge
              { Current =
                  \(current : Period.Current) -> "${show_point current.start} -"
              , Past =
                  \(past : Period.Past) ->
                    "${show_month past.start.month} - ${show_point past.end}"
              }
              period

let endorsement_highlight = \(endorsement : Text) -> "\"${endorsement}\""

in  { positions =
          [ { title = position_title jobs.xplor.intermediate.position
            , company = jobs.xplor.intermediate.company
            , period = long_period jobs.xplor.intermediate.period
            , highlights =
              [ "Worked on migrating production AWS infrastructure to Terraform"
              , "Identified issue with MSBuild producing Debug builds in production"
              ]
            , tech =
              [ knowledge.frameworks.terraform
              , knowledge.services.aws
              , knowledge.services.bamboo
              , knowledge.languages.dhall
              ]
            }
          , { title = position_title jobs.xplor.junior.position
            , company = jobs.xplor.junior.company
            , period = long_period jobs.xplor.junior.period
            , highlights =
              [ "Identified \$35k/year in AWS savings for ECS clusters"
              , "Trained co-op on software development basics"
              , "Designed, built, and maintained AWS systems for internal tool"
              ]
            , tech =
              [ knowledge.languages.csharp
              , knowledge.services.aws
              , knowledge.frameworks.asp_net_mvc
              ]
            }
          , { title = position_title jobs.helmOperations.dev.position
            , company = jobs.helmOperations.dev.company
            , period = long_period jobs.helmOperations.dev.period
            , highlights =
              [ endorsement_highlight
                  "We're definitely going to miss your humour and attention to quality and detail"
              , endorsement_highlight
                  "Talented dev with well-thought-out solutions and attention to good coding practices"
              ]
            , tech =
              [ knowledge.languages.csharp
              , knowledge.frameworks.net_framework
              , knowledge.frameworks.knockout_js
              , knowledge.databases.sql_server
              ]
            }
          , { title = position_title jobs.helmOperations.coop.position
            , company = jobs.helmOperations.coop.company
            , period = short_period jobs.helmOperations.coop.period
            , highlights = [] : List Text
            , tech = [] : List Text
            }
          , { title = position_title jobs.latitude.position
            , company = jobs.latitude.company
            , period = short_period jobs.latitude.period
            , highlights = [] : List Text
            , tech = [] : List Text
            }
          , { title = position_title jobs.uvicCivil.position
            , company = jobs.uvicCivil.company
            , period = short_period jobs.uvicCivil.period
            , highlights = [] : List Text
            , tech = [] : List Text
            }
          , { title = position_title jobs.demonware.position
            , company = jobs.demonware.company
            , period = short_period jobs.demonware.period
            , highlights = [] : List Text
            , tech = [] : List Text
            }
          ]
        : List Resume.Position
    , projects =
          [ { title = projects.finance.title
            , purpose = projects.finance.purpose
            , link = projects.finance.link
            , repo = projects.finance.repo
            , highlights =
              [ "Migrated to .NET due to limitations in hledger"
              , "Created new accounting Nuget packages based on hledger"
              , "Created new build system in .NET based on Haskell's Shake library"
              ]
            , tech =
              [ knowledge.languages.dhall
              , knowledge.languages.csharp
              , knowledge.frameworks.net_7
              ]
            }
          , { title = projects.rentBuy.title
            , purpose = projects.rentBuy.purpose
            , link = projects.rentBuy.link
            , repo = projects.rentBuy.repo
            , highlights = [ "Learned React (with hooks) to build frontend" ]
            , tech =
              [ knowledge.frameworks.react, knowledge.languages.typescript ]
            }
          , { title = projects.resume.title
            , purpose = projects.resume.purpose
            , link = projects.resume.link
            , repo = projects.resume.repo
            , highlights = [] : List Text
            , tech = [ knowledge.languages.csharp, knowledge.languages.dhall ]
            }
          ]
        : List Resume.Project
    , degree =
          { title = capital.knowledge.education.uvic.bachelors.title
          , period = "Sep 2014 - Apr 2019"
          , institution = capital.knowledge.education.uvic.bachelors.university
          , faculty = capital.knowledge.education.uvic.bachelors.faculty
          }
        : Resume.Degree
    , contact = ./contact.dhall
    }
