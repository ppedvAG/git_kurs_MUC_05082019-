#!/usr/bin/env sh

#
# Demo for updating git submodules
#

# Create remote and project for a repo later used as submodule

echo
read -n 1 -s -r -p "updating submodules - make sure you ran crsub.sh first - (key)"
echo
cd gitsubtest/Lib/
echo "{}" > a.json
git add .
git commit -m "Add json file"
git push origin master

echo "Now in localsln/lib do git fetch and git merge origin/master or"
echo "git submodule update --remote Lib"
git submodule update --remote Lib
ls -la Lib
