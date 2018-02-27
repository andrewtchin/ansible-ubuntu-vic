#!/usr/bin/env bash
set -euo pipefail

cd $HOME

echo "Bootstrap"
curl -L https://raw.githubusercontent.com/andrewtchin/ansible-ubuntu-vic/master/ubuntu-bootstrap.sh | sh

echo "Install devel Ansible"
ANSIBLE_DIR="$HOME/ansible"
if [ -d "$ANSIBLE_DIR" ]; then
  rm -rf $ANSIBLE_DIR
fi
git clone https://github.com/ansible/ansible.git --recursive
source ./ansible/hacking/env-setup

echo "Clone ansible-ubuntu-vic"
ANSIBLE_UBUNTU_DIR="$HOME/ansible-ubuntu-vic"
if [ -d "$ANSIBLE_UBUNTU_DIR" ]; then
  rm -rf $ANSIBLE_UBUNTU_DIR
fi
git clone https://github.com/andrewtchin/ansible-ubuntu-vic.git $ANSIBLE_UBUNTU_DIR

cd $ANSIBLE_UBUNTU_DIR
echo "Run ubuntu-desktop"
ansible-playbook -vvv playbooks/ubuntu-desktop-vmware.yml --ask-become-pass -c local --extra-vars=@vars/ubuntu.json -i inventory

echo "Install script exiting"
