# Ansible

## This is a simple Ansible setup to work with AWS.

The current directory layout is the one I use everyday.
I don't have any plans to share the playbooks I use here which, mostly, 
are fetched from Ansible Galaxy and customized.

https://registry.hub.docker.com/u/include/ansible/

## MAX

Max is a private joke still it is a simple wrapper around some ugly `ansible-playbook`commands, to help anyone using it easily every day without thinking too much. Just pick-up a service name for your playbook ```[WHAT]```, a task ```[ACTION]``` and apply it to a destination ```[ENVIRONMENT]```. Thats it.

Lets take a look...

```sh
./max

Usage:
  ./max.sh [WHAT] [ACTION] [ENVIRONMENT]

  ie:
    ./max.sh sample-service-go fetch prd

  list of services:

playbooks/plbk-sample-service-go.yml
      TASK TAGS: [build, deploy, fetch, push, test, undeploy]
playbooks/plbk-system.yml
      TASK TAGS: [docker, ping]
```

Playbooks are stored in its default Ansible location, ```playbooks/``` but I have prefixed mine with ```plbk-```. If you want to change this just edit ```max``` bash script and change ```PLBK_PREFIX="plbk-"``` to anything else to your taste or even leave it blank. 

## Inventory

Dive into ```inventories/stg-sample``` but jump into Ansible manual if you need help on this.

I have a set of server which belong to a cluster ```[services-cluster01]```; and ```[sample-service-go]```, our use case here is child of that same cluster. Notice I've configured some variables specific to that service, ```[sample-servive-go:vars]```.

```ini
[localhost]
localhost ansible_connection=local

[services-cluster01]
a ansible_host=172.21.70.188
b ansible_host=172.21.70.189

[system:children]
services-cluster01

[sample-service-go:children]
services-cluster01

[sample-service-go:vars]
HOST_PORT=8080
CONTAINER_PORT=8080

[all:children]
services-cluster01
system
sample-service-go

[all:vars]
ansible_user=ec2-user
ansible_private_key_file=~/.ssh/lust-stg-master-key.pem
```

## Playbooks and sample task

```yaml
...
- name: deploy container to server
  command: >
    sudo docker run -d --restart=always --name {{ max_what }}
    -p {{ HOST_PORT }}:{{ CONTAINER_PORT }}
    {{ docker_registry }}/{{ max_what }}:{{ max_version }}
  when: max_action == "deploy" and inventory_hostname in groups['{{ max_what }}']
  tags: deploy
...
```
