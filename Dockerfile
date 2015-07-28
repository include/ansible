FROM ansible/ubuntu14.04-ansible
MAINTAINER include <francisco.cabrita@gmail.com>

RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    curl \
    tmux \
    git \
    s3cmd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install boto \
    awscli

WORKDIR /ansible

ADD ./files ./files
ADD ./group_vars ./group_vars
ADD ./inventories ./inventories
ADD ./playbooks ./playbooks
ADD ./roles ./roles
ADD ./ansible.cfg ./
ADD ./site.yml ./
ADD ./ssh_config ./
