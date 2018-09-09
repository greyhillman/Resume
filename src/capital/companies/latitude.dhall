let Month = ../../types/Month.dhall

let Usage = ../../types/Usage.dhall

let jobTitles = ../../common/jobTitles.dhall

let Period = ../../types/Period.dhall

let Job = ../../types/capital/JobPosition.dhall

in  { company = "Latitude Geographics"
    , positions.qaCoop
      =
        let job =
                Job::{
                , title = jobTitles.coop jobTitles.qa
                , period =
                    Period.Short
                      { year = 2018, start = Month.May, end = Month.Aug }
                , languages = Job.Languages::{ type_script = Usage.High }
                , technologies = Job.Technologies::{
                  , web_driver_io = Usage.High
                  }
                , tools = Job.Tools::{ vs_code = Usage.High }
                }
              : Job.Type

        in      job
            /\  { highlights =
                  { design =
                      "Gave recommendations on design of end-to-end tests (\"model\"-based)"
                  , improvement = "Introduced tool to improve QA reports"
                  , testingInfra =
                      "Developed TypeScript automated end-to-end tests for new product"
                  }
                }
    }
