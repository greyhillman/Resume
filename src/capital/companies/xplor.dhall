let Month = ../../types/Month.dhall

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
      }
    , intermediate = Job::{
      , company
      , position = Job.position.permanent "Intermediate Software Developer"
      , period = Period.current 2023 Month.May
      }
    }
