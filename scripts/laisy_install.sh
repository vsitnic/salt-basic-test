#!/usr/bin/env bash

########################################
#  laisy_install.sh
#  This script is demo.
#  Vadim Sitnic vsitnic@gmail.com
########################################

# update apt repos
apt update

# install saltstach master and minion packages
apt install salt-master -y
apt install salt-minion -y

# install git (by default it is installed in ubuntu16)
apt install git -y

# create configuration files
echo -e "file_ignore_glob:\n  - '\*.pyc'\n  - '\*.swp'" > /etc/salt/master
echo "master: localhost" > /etc/salt/minion
echo "mft-test" > /etc/salt/minion_id
echo -e "roles:\n  - demo\n\nssh_users:\n  - mft_user1\n  - mft_user2\n  - mft_user3"   > /etc/salt/grains

# clone salt states from github
mkdir -p /srv/
git clone https://github.com/vsitnic/salt-basic-test.git /srv/salt
cd /srv/salt 
git filter-branch --prune-empty --subdirectory-filter salt HEAD

# restart master and minion 
service salt-master restart
service salt-minion restart

# wait 10 seconds while minion key will appear, then accept it 
sleep 10
salt-key -a mft-test -y

# run logger and users states
salt-run manage.status
salt 'mft-test' state.sls test.logger
salt 'mft-test' state.sls test.users

