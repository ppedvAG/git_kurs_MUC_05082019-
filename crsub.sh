#!/usr/bin/env sh

#
# Demo for using git submodules
#

# Create remote and project for a repo later used as submodule
rm -rf gitsubtest
mkdir gitsubtest
cd gitsubtest
mkdir uplib
cd uplib/
git init --bare
cd ..
echo
read -n 1 -s -r -p "Created uplib repo - Press any key to continue"
echo
mkdir Lib
cd Lib
git clone ../uplib .
dotnet new classlib -n Lib -o .
curl https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore > .gitignore
git add .
git commit -m "Create Lib"
git push origin master
echo
read -n 1 -s -r -p "Created lib repo from uplib - Press any key to continue"
echo
cd ..
mkdir sln
mkdir upsln
cd upsln/
git init --bare
cd ..
echo

# Create remote and project for a sln later using the submodule
read -n 1 -s -r -p "Created upsln repo - Press any key to continue"
echo
cd sln/
git clone ../upsln/ .
dotnet new sln -n app
curl https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore > .gitignore
dotnet new console -n Client --force
dotnet sln app.sln add Client/Client.csproj
git add .
git commit -am "Sln and client"
git push origin master
echo
read -n 1 -s -r -p "Created sln with client - now for submodule - Press any key to continue"
echo
git submodule add ../uplib/ Lib
git commit -am "Add submodule"
cd client/
dotnet add reference ../lib/lib.csproj
cd ..
git commit -am "Lib reference"
git push origin master
cd ..
echo

# Clone into new local repo and get the submodules
read -n 1 -s -r -p "Pulling sln into new project and get submodules - Press any key to continue"
echo
git clone upsln localsln
cd localsln
git submodule init
git submodule update
echo "Could also use git clone xy --recurse-submodules"
echo "Next: Work on submodule lib and pull it into project"

