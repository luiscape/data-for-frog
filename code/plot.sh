#!/bin/sh
PLOTDIR='../plots'
HEADER='<!DOCTYPE html>\n
<html>\n
<head>\n
  <meta charset="utf-8">\n
  <link stylesheet href="style.css">\n
</head>\n
<body>\n
'
FOOTER='</body>\n
</html>\n
'

cd $PLOTDIR
echo $HEADER
for f in *.png
do
  echo "<img src=\"$f\"></img>"
done
echo $FOOTER
