import strutils, os, strformat, times

proc changeFile(beforeFile, afterFile, appName, author, dt: string) =
  let body =
    readFile(beforeFile)
      .replace("<appname>", appName)
      .replace("<author>", author)
      .replace("<date>", dt)
  writeFile(beforeFile, body)
  echo &"{beforeFile} was replaced."

  if afterFile == "": return
  moveFile(beforeFile, afterFile)
  echo &"{beforeFile} was renamed {afterFile}."

let
  appName = commandLineParams()[0]
  author = commandLineParams()[1]
  now = now().format("yyyy")

changeFile("APPNAME.nimble", &"{appName}.nimble", appName, author, now)
changeFile("README.rst", "", appName, author, now)
changeFile("src"/"APPNAME.nim", &"src"/"{appName}.nim", appName, author, now)
changeFile("tests"/"test1.nim", "", appName, author, now)
