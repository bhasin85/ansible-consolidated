
### Prepare
```
mkdir -p roles/common
ansible-galaxy install yaegashi.blockinfile -p ./roles/common

Being able to provision in root is pretty convenient
- sshd and rsync must be installed, and copy authorized_key into /roo/.ssh 
  and edit /etc/ssh/sshd_config to permit root login

ansible-playbook roles/common/dell_7450.yml  -i laptop, -v -u root

```


### Chef Provisioning
```
 cd systemd-nspawn-example/
 sudo ./build.sh 
 sudo ./start.sh 
 sudo systemctl  start wily 
 ssh-keygen -f "/home/user/.ssh/known_hosts" -R wily
 ssh root@wily
 cd chef
 knife solo prepare root@wily
 knife solo cook root@wily  -N wily  ./nodes/node.json 2>&1 | tee log.txt
 ssh root@wily
```

### Useful flags

```
--private-key ~/.ssh/id_rsa
--ask-sudo-pass
-k ask pass
-u specify username 
-v verbose
// don't use ssh
-c local

# Use ping module
ansible all -i nc2, -c local -m ping
```

### Resources
```
https://github.com/phred/5minbootstrap/blob/master/bootstrap.yml

http://www.mechanicalfish.net/start-learning-ansible-with-one-line-and-no-files/

http://docs.ansible.com/ansible/playbooks_best_practices.html
```


