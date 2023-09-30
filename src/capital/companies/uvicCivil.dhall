let Month = ../../types/Month.dhall

let Usage = ../../types/Usage.dhall

let jobTitles = ../../common/jobTitles.dhall

let Period = ../../types/Period.dhall

let Job = ../../types/capital/JobPosition.dhall

in  { company = "UVic Civil Engineering"
    , positions.devCoop
      =
        let job =
                Job::{
                , title = jobTitles.coop jobTitles.softwareDev
                , period =
                    Period.past
                      { start = Period.point 2017 Month.May
                      , end = Period.point 2017 Month.Aug
                      }
                , languages = Job.Languages::{ python3 = Usage.High }
                , technologies = Job.Technologies::{ docker = Usage.Low }
                , tools = Job.Tools::{ vs_code = Usage.High }
                }
              : Job.Type

        in      job
            /\  { highlights =
                  { refactoring =
                      "Refactored researcher's code to allow for future development (also fixed critical issue)"
                  , communication =
                      "Explained technical concepts to non-technical people"
                  }
                , quotes.ralph
                  =
                    "Good at explaining technical concepts to non-technical people"
                }
    }
