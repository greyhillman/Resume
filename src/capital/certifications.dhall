let Certification = ../types/capital/Certification.dhall

let Month = ../types/Month.dhall

let Period = ../types/Period.dhall

in  { aws.solutions_architect_associate
      = Certification::{
      , name = "AWS Certified Solutions Architect - Associate"
      , organization = "Amazon Web Services (AWS)"
      , valid =
          Period.past
            { start = Period.point 2023 Month.Oct
            , end = Period.point 2026 Month.Oct
            }
      , url = Some
          "https://www.credly.com/badges/6d92b1c5-e35f-411f-90b0-18eed1fb7d04/linked_in_profile"
      }
    }
