


### Prepare
```
mkdir -p roles/common
ansible-galaxy install yaegashi.blockinfile -p ./roles/common

Being able to provision in root is pretty convenient
- make sure sshd and rsync are installed, and copy authorized_key into /roo/.ssh 
  and edit /etc/ssh/sshd_config to permit root login

ansible-playbook roles/common/dell_7450.yml  -i laptop, -v -u root

./mount.ss /home
ansible-playbook roles/common/devenv.yml  -i laptop, -v -u root 

rsync -avzP ~/.ssh meteo@laptop:~/
ansible-playbook roles/common/desktop.yml  -i laptop, -v
```


### Chef Provisioning
```
 cd systemd-nspawn-example/
 sudo ./build2.sh 
 sudo ./start.sh 
 sudo systemctl  start wily 
 ssh-keygen -f "/home/meteo/.ssh/known_hosts" -R wily
 ssh root@wily
 cd chef
 knife solo prepare root@wily
 knife solo cook root@wily  -N wily  ./nodes/3-aws-syd.emii.org.au.json 2>&1 | tee log.txt
 ssh root@wily
```

# start container
```
sudo systemctl start wily
```

# prepare
```
knife solo prepare root@wily
```

# provision
```
knife solo cook root@wily  -N wily  ./nodes/3-aws-syd.emii.org.au.json
```




### Resources
https://github.com/phred/5minbootstrap/blob/master/bootstrap.yml

http://www.mechanicalfish.net/start-learning-ansible-with-one-line-and-no-files/

http://docs.ansible.com/ansible/playbooks_best_practices.html

### todo

chefdk

add universe for ubuntu, non-free for debian 
apt keys

ansible-galaxy install yaegashi.blockinfile -p roles


### specify a pem
--private-key ~/.ssh/id_rsa


### Useful flags
--ask-sudo-pass

-k ask pass

-u specify username 
-v verbose
// don't use ssh
-c local


### Ansible Provisioning

ansible-playbook myplaybook.yml -i localhost,
ansible-playbook myplaybook.yml -i nc2, -u debian --private-key ~/.ssh/julian3.pem

### Use command module to run command 
ansible all -i nc2, -u debian --private-key ~/.ssh/julian3.pem -m command -a 'echo hello'


### Use ping module
ansible all -i nc2, -c local -m ping


### examples,

  // permissions
  file: path=/home/{{user}}/dotfiles owner={{user}} group={{user}} recurse=yes

  apt_key: keyserver=keyserver.ubuntu.com id=36A1D7869245C8950F966E92D8576A8BA88D21E9

  // condition 
  - name: Update Shellshock (Debian)
  apt: name=bash
    state=latest
    update_cache=yes
  when: ansible_os_family == "Debian"




