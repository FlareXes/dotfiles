#!/bin/sh

repos_paths=$(realpath ./*)
read -sp "Password: " password

for path in $repos_paths 
do
  echo -e "\n$path"
  [[ -d $path ]] && cd $path && expect -c "spawn git fetch origin; expect -nocase \"Enter passphrase for key '$HOME/.ssh/id_ed25519':\" {send \"$password\r\"; interact}" && git reset --hard FETCH_HEAD
done

echo "DONE!, $?"

7z a -mhe=on -p all_repos.7z ../all_repos

echo "DONE!, $?"
