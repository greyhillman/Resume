module Main where

import Development.Shake
import Development.Shake.Dhall
import Development.Shake.FilePath
import Dhall

main :: IO ()
main = shakeArgs shakeOptions $ do
  want ["bin/resume.html", "bin/cover.html"]

  "bin/resume.html" %> \out -> do
    needDhall ["resume.dhall"]
    need ["bin/resume.css"]
    html <- liftIO $ inputFile auto "resume.dhall"
    writeFileChanged out html

  "bin/cover.html" %> \out -> do
    needDhall ["cover.dhall"]
    need ["bin/cover.css"]
    html <- liftIO $ inputFile auto "cover.dhall"
    writeFileChanged out html

  "bin/*.css" %> \out -> do
    let file = "src/style" </> takeBaseName out -<.> "less"
    need [file]
    Stdout content <- command [] "npx" ["lessc", file]
    writeFileChanged out content
