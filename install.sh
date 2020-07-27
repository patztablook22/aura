#! /usr/bin/bash

DIR="$HOME/.config"
CWD=$(pwd)
OKI=true

if [ $(id -u) = 0 ]; then
  echo "run this as a normal user"
  exit 1
fi

phase()
{
  printf "\n"
  printf "  $1\n"
  printf "  " 

  for (( i = 0; i < ${#1}; i++ )); do
    printf "~"
  done

  printf "\n\n"
}

hr()
{
  for (( i = 0; i < 55; i++ )); do
    printf "#"
  done

  printf "\n"
}

phase DEPENDENCIES
sudo xbps-install -Syu git ruby

phase CLONING
mkdir -p $DIR
cd $DIR

if [ -e aura ]; then
  echo "AURA seems to be here already... reinstalling"
  rm -rf aura
fi

git clone https://github.com/patztablook22/aura/

phase SUCCESS
echo "linking executable into current working directory"
cd $CWD

target=$DIR/aura/aura
ln -sf $target .

if [ " $target" = "$(ls -l aura | cut -d'>' -f2)" ]; then
  echo "done"
  echo
else
  echo "linking FAILED but myeh do it manually or whatever"
  echo
  OKI=false
fi

echo "AURA dir FYI: $DIR/aura/"
echo " ... all files are being stored in there by deafult"
echo " ... to change that, use either CLI options or"
echo " ... $DIR/aura/config.txt"
echo

if [ $OKI != true ]; then
  exit
fi

hr
echo
echo "USAGE"
echo 
echo "    ./aura --help"
echo
echo "INITIALIZE (when eventually configured)"
echo
echo "    ./aura --init"
echo
hr
echo

