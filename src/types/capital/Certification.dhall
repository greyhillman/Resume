let Period = ../Period.dhall

let Certification
    : Type
    = { name : Text
      , organization : Text
      , valid : Period.Type
      , url : Optional Text
      }

in  { Type = Certification, default.url = None Text }
