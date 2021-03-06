#!/bin/bash

sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf


#echo "Updating..."
#sudo apt update
#sudo apt install -y apt-transport-https


# Install Python 3
#sudo apt install -y python3
# Install Ansible
#sudo apt install -y ansible

# Generating SSH_KEY to Ansible deployment.
#ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa


# Install VirtualBox & Extension Packs
#sudo apt install -y virtualbox virtualbox-ext-pack

# Getting Keys & Add Kubernetes REPO to APT source list & Install kubectl to interact with Cluster
#curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
#touch /etc/apt/sources.list.d/kubernetes.list 
#echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
#echo "Updating..."
#sudo apt update
#sudo apt install -y kubectl

# Install Minikube to run single node Kubernetes Cluster on VM
#curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.28.2/minikube-linux-amd64
#sudo chmod +x minikube && sudo mv minikube /usr/local/bin/

# Start Minikube & Kubectl to show API Versions 
#sudo minikube start
#sudo kubectl api-versions
