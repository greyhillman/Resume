let Position
    : Type
    = { title : Text
      , company : Text
      , period : Text
      , highlights : List Text
      , tech : List Text
      }

let Project
    : Type
    = { title : Text
      , purpose : Text
      , link : Optional Text
      , repo : Optional Text
      , highlights : List Text
      , tech : List Text
      }

let Degree
    : Type
    = { title : Text, period : Text, institution : Text, faculty : Text }

in  { Position, Project, Degree }
