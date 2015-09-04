FROM ubuntu:14.04
MAINTAINER include <francisco.cabrita@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    language-pack-en && \
    locale-gen en_US.UTF-8 && dpkg-reconfigure locales && \
    apt-get install -y \
    build-essential \
    gcc \
    make \
    python-dev \
    python-software-properties \
    python-simplejson \
    wget \
    curl \
    tmux \
    git \
    s3cmd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip install \
    boto \
    awscli \
    paramiko \
    PyYAML \
    Jinja2 \
    httplib2 \
    six \
    ansible

WORKDIR /ansible

ADD ./files ./files
ADD ./group_vars ./group_vars
ADD ./inventories ./inventories
ADD ./playbooks ./playbooks
ADD ./roles ./roles
ADD ./ansible.cfg ./
ADD ./site.yml ./
ADD ./ssh_config ./
