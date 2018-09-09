let Languages = ../types/Languages.dhall

in    { `c#` = "C#"
      , html = "HTML5"
      , css = "CSS3"
      , less_css = "LessCSS"
      , haskell = "Haskell"
      , js = "JavaScript ES6"
      , type_script = "TypeScript"
      , python2 = "Python2"
      , python3 = "Python3"
      , dhall = "Dhall"
      , java = "Java"
      }
    : Languages.Type Text
