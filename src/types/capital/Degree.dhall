let Period = ../Period.dhall

in    { title : Text
      , faculty : Text
      , university : Text
      , period : Period
      , highlights : List Text
      }
    : Type
