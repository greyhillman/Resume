let Period = ../Period.dhall

let Usage = ../Usage.dhall

let KnowledgeUsage = ./Job/KnowledgeUsage.dhall

let Relation = < Coworker | Boss >

let Person
    : Type
    = { name : Text, position : Text, relation : Relation }

let Endorsement
    : Type
    = { quote : Text, person : Person }

let Contract = < Coop | Permanent >

let Position
    : Type
    = { title : Text, contract : Contract }

let Job
    : Type
    = { company : Text
      , position : Position
      , period : Period.Type
      , skills : List Text
      , endorsements : List Endorsement
      , knowledge : List KnowledgeUsage
      }

in  { Type = Job
    , position =
      { coop = \(title : Text) -> { title, contract = Contract.Coop } : Position
      , permanent =
          \(title : Text) -> { title, contract = Contract.Permanent } : Position
      }
    , used =
        \(usage : Usage) ->
        \(knowledge : Text) ->
          { knowledge, usage } : KnowledgeUsage
    , endorsed =
        \(quote : Text) ->
        \(name : Text) ->
        \(position : Text) ->
        \(relation : Relation) ->
          { quote, person = { name, position, relation } } : Endorsement
    , Relation
    , default =
      { skills = [] : List Text
      , endorsements = [] : List Endorsement
      , knowledge = [] : List KnowledgeUsage
      }
    }
