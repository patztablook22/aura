#! /usr/bin/bash

# where to put the aura directory
BASEDIR="$HOME/.config"

# number of dependencies
DEPENDS=5

# package manager commands to try
MANAGER=(                                                     \
  "apt-get install -y       git ruby tar binutils xz-utils"   \
  "pacman -S --noconfirm    git ruby tar binutils xz"         \
  "xbps-install -y          git ruby tar binutils xz"         \
  "dnf install -Y           git ruby tar binutils xz"         \
)                                                             \

# progress logging
log()
{
  echo "[$1] $2 "
}

# make sure permissions are granted
sudo true
if [ $? != 0 ]; then
  log FAIL "root permissions needed"
  exit 1
fi

# try the package manager commands
for it in ${!MANAGER[@]}; do

  cmd=${MANAGER[$it]}
  tmp=$(echo $cmd | cut -d" " -f1)
  type $tmp > /dev/null 2>&1

  if [ $? = 0 ]; then
    todo=$cmd
  fi

done 

# no command plausible
if [ "$todo" = "" ]; then
  echo
  echo "Unfortunately this installer doesn't support your distribution"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "Don't panic though! Just follow the instructions at:"
  echo "https://github.com/patztablook22/aura#manual-installation"
  echo
  exit 1
fi

# executed on fail
fail()
{
  log FAIL "installation failed"
}

trap fail EXIT
set -e

# extract dependencies from the command
# and log them (only cosmetic)
buf="\$(NF)"
for (( i = 1; i < $DEPENDS; i++ )); do
  buf="$buf,\$(NF-$i)"
done
buf=$(echo $todo | awk "{print $buf}")

log DEPS "$buf"

# install dependencies
sudo $todo > /dev/null 2>&1

# clone aura into $BASEDIR/aura
mkdir -p $BASEDIR  > /dev/null 2>&1
cd $BASEDIR

if [ -e aura ]; then
  log AURA reinstalling
  rm -rf aura
else
  log AURA installing
fi

git clone -q https://github.com/patztablook22/aura/

# /usr/bin/aura executable
sudo install aura/aura /usr/bin/

# done
log DONE successful
trap - EXIT
