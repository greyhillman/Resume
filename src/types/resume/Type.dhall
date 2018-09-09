let Contact = ../Contact.dhall

let Job = ./Job.dhall

let Project = ./Project.dhall

let Knowledge = ./Knowledge.dhall

let Education = ./Education.dhall

in    { contact : Contact
      , employment : List Job
      , projects : List Project
      , knowledge : { education : List Education, other : List Knowledge }
      }
    : Type
