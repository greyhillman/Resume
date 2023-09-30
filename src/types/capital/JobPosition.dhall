let Usage = ../Usage.dhall

let Tools = ../../types/Tools.dhall

let Methodologies = ../../types/Methodologies.dhall

let Databases = ../../types/Databases.dhall

let Frameworks = ../../types/Frameworks.dhall

let Technologies = ../../types/Technologies.dhall

let Period = ../Period.dhall

let Languages = ../../types/Languages.dhall

let LanguageUsage =
      { Type = Languages.Type Usage
      , default = Languages.default Usage Usage.None
      }

let ToolUsage =
      { Type = Tools.Type Usage, default = Tools.default Usage Usage.None }

let MethodologyUsage =
      { Type = Methodologies.Type Usage
      , default = Methodologies.default Usage Usage.None
      }

let DatabaseUsage =
      { Type = Databases.Type Usage
      , default = Databases.default Usage Usage.None
      }

let FrameworkUsage =
      { Type = Frameworks.Type Usage
      , default = Frameworks.default Usage Usage.None
      }

let TechnologyUsage =
      { Type = Technologies.Type Usage
      , default = Technologies.default Usage Usage.None
      }

let Job =
      { Type =
          { title : Text
          , period : Period.Type
          , languages : LanguageUsage.Type
          , tools : ToolUsage.Type
          , methodologies : MethodologyUsage.Type
          , databases : DatabaseUsage.Type
          , frameworks : FrameworkUsage.Type
          , technologies : TechnologyUsage.Type
          }
      , default =
        { languages = LanguageUsage.default
        , tools = ToolUsage.default
        , methodologies = MethodologyUsage.default
        , databases = DatabaseUsage.default
        , frameworks = FrameworkUsage.default
        , technologies = TechnologyUsage.default
        }
      }

in      Job
    /\  { Languages = LanguageUsage
        , Tools = ToolUsage
        , Methodologies = MethodologyUsage
        , Databases = DatabaseUsage
        , Frameworks = FrameworkUsage
        , Technologies = TechnologyUsage
        }
