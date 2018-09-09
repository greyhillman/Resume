let capital = ../capital.dhall

let Languages = ../types/Languages.dhall

let Databases = ../types/Databases.dhall

let Frameworks = ../types/Frameworks.dhall

let Tools = ../types/Tools.dhall

let Technologies = ../types/Technologies.dhall

let Methodologies = ../types/Methodologies.dhall

let KnowledgeLevel = ../types/KnowledgeLevel.dhall

let Knowledge = { name : Text, level : KnowledgeLevel }

let to_knowledge =
      \(name : Text) -> \(level : KnowledgeLevel) -> { name, level }

let languages =
      let names = ../common/languages.dhall

      in  Languages.zip
            Text
            KnowledgeLevel
            Knowledge
            names
            capital.knowledge.languages
            to_knowledge

let databases =
      let names = ../common/databases.dhall

      in  Databases.zip
            Text
            KnowledgeLevel
            Knowledge
            names
            capital.knowledge.databases
            to_knowledge

let frameworks =
      let names = ../common/frameworks.dhall

      in  Frameworks.zip
            Text
            KnowledgeLevel
            Knowledge
            names
            capital.knowledge.frameworks
            to_knowledge

let tools =
      let names = ../common/tools.dhall

      in  Tools.zip
            Text
            KnowledgeLevel
            Knowledge
            names
            capital.knowledge.tools
            to_knowledge

let methodologies =
      let names = ../common/methodologies.dhall

      in  Methodologies.zip
            Text
            KnowledgeLevel
            Knowledge
            names
            capital.knowledge.methodologies
            to_knowledge

in  [ { name = "Languages"
      , values =
        [ languages.`c#`
        , languages.html
        , languages.haskell
        , languages.type_script
        ]
      }
    , { name = "Databases"
      , values = [ databases.sql_server, databases.postgres ]
      }
    , { name = "Frameworks"
      , values =
        [ frameworks.knockout.{ name, level }
        , frameworks.nunit.{ name, level }
        , frameworks.net.{ name, level }
        ]
      }
    , { name = "Tools"
      , values =
        [ tools.git, tools.jira, tools.confluence, tools.visual_studio ]
      }
    , { name = "Methodolgies"
      , values = [ methodologies.agile, methodologies.scrum ]
      }
    ]
