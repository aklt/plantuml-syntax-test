#!/bin/sh

cat << EOHEADER
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Test plantuml-syntax</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="style.css" type="text/css" /> 
  </head>
  <body>
EOHEADER

for i in "$@"; do
  echo "<div>"
  echo "<h3>$i</h3>"
  cat "$i"
  echo "</div>"
done

cat << EOFOOTER
  </body>
</html>
EOFOOTER


