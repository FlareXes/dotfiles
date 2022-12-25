#!/bin/sh

repos=$(cat ./repos)
read -sp "Password: " password

for repo in $repos
do
  echo -e "\n$repo"
  expect -c "spawn git clone git@github.com:flarexes/$repo; expect -nocase \"Enter passphrase for key '$HOME/.ssh/id_ed25519':\" {send \"$password\r\"; interact}"
done

echo "DONE!, $?"

