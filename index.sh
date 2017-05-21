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
      h1, h2 {
        color: #AAA;
      }
      h2 {
        font-size: 120%;
        margin: 1em 0 0 0;
      }
      a {
        text-decoration: none;
        color: #7AF;
      }
      li {
        list-style-type: none;
      }
    </style>
  </head>
  <body>
  <h1>PlantUML syntax examples</h1>
EOHEADER

echo "<ul>"
for i in $(echo "$@" | tr ' ' '\n' | sort); do
  baseName=$(echo "$i" | sed -e 's/^\([^.]\+\).*$/\1/')
  echo "<li><a href=\"#$baseName\">$baseName</a></li>"
done
echo "</ul><hr />"

for i in $(echo "$@" | tr ' ' '\n' | sort); do
  baseName=$(echo "$i" | sed -e 's/^\([^.]\+\).*$/\1/')
  echo "<a name=\"$baseName\"></a><table><tr><td>"
  echo "<h2>$baseName</h2>"
  cat "$i"
  echo "</td><td>"
  echo "<img src=\"${baseName}.png\" />"
  echo "</td></tr></table>"
  echo "<hr />"
done

cat << EOFOOTER
  </body>
</html>
EOFOOTER


