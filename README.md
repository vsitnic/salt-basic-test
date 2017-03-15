# salt-basic-test

This is a demo how to add a cron job and a user to ubuntu instance

### Requirements

- install saltstack master and minion
- connect instance as minion to itself
- create `logger.sh` script with following requirements:
  - find all files in /var/log/ by mask `*.log`
  - count the number of lines in found files
  - save(append) result in `/root/counts.log` in the format "datetime|filename|number of lines"
- using salt 
  - deploy `logger.sh`
  - run it every 30 minutes
  - create 3 users 
  - allow logon using `football` ssh key

note: 
according to requirements only `*.log` (with dot) will be processed. Files like `/var/log/maillog` will be ignored.

### Install

- login to instanceand get root privileges
- run following command 
```bash
curl -s https://raw.githubusercontent.com/vsitnic/salt-basic-test/master/scripts/laisy_install.sh | bash
```

### changes in `/etc/salt/` folder

All steps described in this section were added to install script, you don't deed to apply them.

- set `file_ignore_glob` variable value. It mustbe set to avoid WARNING messages during states execution (file /etc/salt/master)
- set master host in `/etc/salt/minion` (as per requirement it is localhost)
- set minion ID in `/etc/salt/minion_id`
- define roles and users in grains file `/etc/salt/grains` (this doesn't required by salt. I use it in salt states)

### demo instance
- ip address : 188.0.232.35
- username : ubuntu
- please use rsa key attached to email
