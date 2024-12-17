# 1) Getting start with my playbook
#### Install a ansible server or images (using Docker):
# Version information:
```
- Ansible [core 2.15.13]
- Python version = 3.9.20 (main, Sep  9 2024, 00:00:00) [GCC 11.5.0 20240719 (Red Hat 11.5.0-2)]
- jinja version = 3.1.2
- libyaml = True
```
# Ansible.cfg
```
[defaults]
inventory =  /home/minhvx/Ansible_projects/VHKT_VTT/inventory/hosts.ini
roles_path = /home/minhvx/Ansible_projects/VHKT_VTT/roles
```
# Inventory
```
<!--  Use with root user
[VHKT_server]
centos9 ansible_host=localhost
centos7 ansible_host=192.168.153.31
ubuntu2204 ansible_host=192.168.153.44
-->

<!-- Use with user can sudo -->
[VHKT_Test_lab]
ansible-server-testlab ansible_host=minhvx ansible_user=minhvx ansible_become=yes ansible_become_method=sudo
```

# Playbook
```
---
- name: Check OS information
  hosts: VHKT_server
  become: true  # User can sudo
  roles:
    - check_ip_version_kernel
    - check_timezone
    - check_var_partition_conf
 .....
```