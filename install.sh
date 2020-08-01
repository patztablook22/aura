#! /usr/bin/bash

BASEDIR="$HOME/.config"
DEPENDS="git ruby"
MANAGER=(                       \
  "apt-get install -y"          \
  "pacman -S --noconfirm"       \
  "xbps-install -y"             \
  "dnf install -Y"              \
)

if [ $(id -u) = 0 ]; then
  echo "run this as a normal user"
  exit 1
fi

for it in ${!MANAGER[@]}; do

  cmd=${MANAGER[$it]}
  tmp=$(echo $cmd | cut -d" " -f1)
  type $tmp > /dev/null 2>&1

  if [ $? = 0 ]; then
    todo=$cmd
  fi

done 

if [ "$todo" = "" ]; then
  echo
  echo "this installer doesn't support your distribution"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "follow the instructions at"
  echo "https://github.com/patztablook22/aura#manually"
  echo
  exit 1
fi

log()
{
  echo "[$1] $2 "
}

fail()
{
  log FAIL installation failed
}

trap fail EXIT
set -e

log DEPS "$DEPENDS"
sudo $todo $DEPENDS > /dev/null

mkdir -p $BASEDIR  > /dev/null 2>&1
cd $BASEDIR

if [ -e aura ]; then
  log AURA reinstalling
  rm -rf aura
else
  log AURA installing
fi

git clone -q https://github.com/patztablook22/aura/
sudo install aura/aura /usr/bin/

log DONE successful
trap - EXIT
