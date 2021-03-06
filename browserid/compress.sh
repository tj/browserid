#!/bin/sh

YUI_LOCATION='../../static/steal/build/scripts/yui.jar'

echo ''
echo '****Building dialog HTML, CSS, and JS****'
echo ''

cd static
steal/js dialog/scripts/build.js

cd dialog
java -jar $YUI_LOCATION production.js -o production.min.js
mv production.min.js production.js

echo ''
echo '****Building BrowserID.org HTML, CSS, and JS****'
echo ''

cd ../js
# Yes, this is the right way of doing this.  We are compressing ONLY 
# browserid.js because both jquery and underscore are already compressed.  Then 
# take the three of them, concatinate them together, and create lib.min.js
java -jar $YUI_LOCATION browserid.js -o browserid.min.js
cat jquery-1.6.2.min.js ../dialog/resources/underscore-min.js browserid.min.js > lib.min.js

cd ../css
cat github.css style.css > browserid.css
java -jar $YUI_LOCATION browserid.css -o browserid.min.css



