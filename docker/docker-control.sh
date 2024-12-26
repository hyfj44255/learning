#!/bin/bash

# docker pull kindest/node:v1.31.2@sha256:18fbefc20a7113353c7b75b5c869d7145a6abd6269154825872dc59c1329912e

action=$1
echo "parameter is: "$action

if [[ $action == "start" ]]; then
    echo "starting docker"
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service

    sudo systemctl restart docker.service
    sudo systemctl restart containerd.service
    
elif [[ $action == "stop" ]]; then
    echo "stop docker"
    sudo systemctl disable docker.service
    sudo systemctl disable docker.socket
    sudo systemctl disable containerd.service
    sudo systemctl stop docker.socket
    sudo systemctl stop containerd
else
    echo "do nothing"
fi