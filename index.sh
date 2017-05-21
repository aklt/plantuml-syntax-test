#!/bin/sh

cat << EOHEADER
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Test plantuml-syntax</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="style.css" type="text/css" /> 
    <style>
      body {
        background-color: #444;
      }
      img {
        margin-left: 2em;
      }
    </style>
  </head>
  <body>
EOHEADER

for i in "$@"; do
  baseName=$(echo "$i" | sed -e 's/^\([^.]\+\).*$/\1/')
  echo "<h3>$baseName</h3>"
  echo "<table><tr><td>"
  cat "$i"
  echo "</td><td>"
  echo "<img src=\"${baseName}.png\" />"
  echo "</td></tr></table>"
done

cat << EOFOOTER
  </body>
</html>
EOFOOTER


