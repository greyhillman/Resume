let Tools = ../types/Tools.dhall

in    { vim = "vim"
      , tmux = "tmux"
      , visual_studio = "Visual Studio"
      , git = "git"
      , vs_code = "VSCode"
      , jira = "JIRA"
      , confluence = "Confluence"
      , powershell = "PowerShell"
      }
    : Tools.Type Text
