let capital = ../capital/package.dhall

let Resume = ../types/resume/package.dhall

let helmOperations = capital.experience.companies.helmOperations

let latitude = capital.experience.companies.latitude

let uvicCivil = capital.experience.companies.uvicCivil

let demonware = capital.experience.companies.demonware

let quote = \(quote : Text) -> "\"${quote}\""

in    [ { company = helmOperations.company
        , positions =
          [ let dev = helmOperations.positions.dev

            in  { title = dev.title
                , period = dev.period
                , highlights =
                  [ quote dev.quotes.peter
                  , dev.highlights.testInfra
                  , dev.highlights.quickLearner
                  ]
                }
          , { title = helmOperations.positions.coop.title
            , period = helmOperations.positions.coop.period
            , highlights = [] : List Text
            }
          ]
        }
      , { company = latitude.company
        , positions =
          [ let qaCoop = latitude.positions.qaCoop

            in  { title = qaCoop.title
                , period = qaCoop.period
                , highlights =
                  [ qaCoop.highlights.testingInfra
                  , qaCoop.highlights.design
                  , qaCoop.highlights.improvement
                  ]
                }
          ]
        }
      , { company = uvicCivil.company
        , positions =
          [ let devCoop = uvicCivil.positions.devCoop

            in  { title = devCoop.title
                , period = devCoop.period
                , highlights = [ quote devCoop.quotes.ralph ]
                }
          ]
        }
      , { company = demonware.company
        , positions =
          [ let devCoop = demonware.positions.devCoop

            in  { title = devCoop.title
                , period = devCoop.period
                , highlights = [] : List Text
                }
          ]
        }
      ]
    : List Resume.Job
