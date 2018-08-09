#!/bin/bash - now in LF

date +"%b %d %H:%M:%S"
echo "Installing aptitude"
sudo apt-get update --quiet
sudo apt-get install --assume-yes -qq aptitude 

date +"%b %d %H:%M:%S"
echo "Patching OS using aptitude"
sudo aptitude update --assume-yes --quiet
sudo aptitude install git lynx moreutils --assume-yes --quiet
sudo aptitude full-upgrade --assume-yes --quiet
sudo aptitude autoclean --assume-yes --quiet

date +"%b %d %H:%M:%S"
echo "Updating the labuser .bashrc for coloured prompts"
[[ ! -f ~labuser/.bashrc.orig ]] && cp -p ~labuser/.bashrc ~labuser/.bashrc.orig
curl --silent https://raw.githubusercontent.com/azurecitadel/vdc-networking-lab/master/nested/.bashrc > ~labuser/.bashrc

if [ -f /var/run/reboot-required -a "$(whoami)" = "root" ]
then
    date +"%b %d %H:%M:%S"
    echo "System restart required - submitting at job"
    at now + 1 min <<-EOF
	shutdown --reboot --no-wall now
	EOF
fi

exit 0