#!/bin/sh

# generate images
Rscript code/plot.R

# make html
PLOTDIR='plots'
INDEXFILE='index.html'
STYLEFILE='style.css'
HEADER='<!DOCTYPE html>\n
<html>\n
<head>\n
  <meta charset="utf-8">\n
  <link rel="stylesheet" href="style.css">\n
  <title>Kenya Indicators</title>
</head>\n
<body>\n
<h1>Kenya Indicators</h1>\n
'
FOOTER='</body>\n
</html>\n
'
CSS='
img {\n
  width:3in;\n
  height:3in;\n
}\n
'

cd $PLOTDIR
echo $HEADER > $INDEXFILE
for f in *.png
do
  echo "<img src=\"$f\"></img>" >> $INDEXFILE
done
echo $FOOTER >> $INDEXFILE

echo $CSS > $STYLEFILE
