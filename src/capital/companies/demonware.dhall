let Month = ../../types/Month.dhall

let Usage = ../../types/Usage.dhall

let jobTitles = ../../common/jobTitles.dhall

let Period = ../../types/Period.dhall

let Job = ../../types/capital/JobPosition.dhall

in  { company = "Demonware"
    , positions.devCoop
      =
        let job =
                Job::{
                , title = jobTitles.coop jobTitles.softwareDev
                , period =
                    Period.past
                      { start = Period.point 2016 Month.Sep
                      , end = Period.point 2016 Month.Dec
                      }
                , languages = Job.Languages::{ python2 = Usage.High }
                , tools = Job.Tools::{ git = Usage.High }
                , methodologies = Job.Methodologies::{
                  , agile = Usage.Low
                  , scrum = Usage.Low
                  }
                }
              : Job.Type

        in      job
            /\  { highlights =
                  { basics = "Learned basics of software development"
                  , agile = "Participated in Agile development processes"
                  }
                }
    }
