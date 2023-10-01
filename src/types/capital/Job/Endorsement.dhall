let Relation = ./Relation.dhall

let Person
    : Type
    = { name : Text, position : Text, relation : Relation }

in  { quote : Text, person : Person }
