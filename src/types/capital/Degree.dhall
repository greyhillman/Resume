let Period = ../Period.dhall

in    { title : Text
      , faculty : Text
      , university : Text
      , period : Period.Type
      , highlights : List Text
      }
    : Type
