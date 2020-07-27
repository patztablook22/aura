#! /usr/bin/bash

DIR="$HOME/.config"
CWD=$(pwd)

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

phase DEPENDENCIES
sudo xbps-install -Syu git ruby

phase CLONING
mkdir -p $DIR
cd $DIR

if [ -e aura ]; then
  echo "aura seems to be here already... reinstalling"
  rm -rf aura
fi

git clone https://github.com/patztablook22/aura/

phase SUCCESS
echo "linking executable into current working directory"
cd $CWD
ln -sf $DIR/aura/aura .
echo
echo "USAGE: ./aura pkgname"
echo

