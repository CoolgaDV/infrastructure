#!/usr/bin/env bash

. ../../common/common.sh

info "Running Ansible scripts ..."
ansible-playbook -i ../common-inventory.yml play-book.yml