#!/bin/bash

# find the path to this file http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directorys-stored-in
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

DOTFILES_PATH=$DIR/dotfiles
PRIVATE_PATH=$DIR/../../private

install-dotfiles() {
  echo "Installing dotfiles"
  for file in $(find $DOTFILES_PATH -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp"); do
    f=$(basename $file)
    echo "  $f"
    ln -sfn $file $HOME/$f
  done
}

install-private() {
  echo "Linking private files"
  for file in $(find $PRIVATE_PATH -name ".*" -not -name ".*.swp"); do
    f=$(basename $file)
    echo "  $f"
    ln -sfn $file $HOME/$f
  done
}

config-workspace() {
  install-dotfiles
  install-private
}
