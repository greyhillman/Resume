let Account = ./ContactAccount.dhall

in    { name : Text, address : Text, email : Text, accounts : List Account }
    : Type
