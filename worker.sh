#!/bin/bash

sudo apt update
echo -e "\n################################################### DOCKER ###################################################\n";
sudo apt install containerd -y
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
echo -e "\n################################################### Kubernetes ###################################################\n";
sudo apt install apt-transport-https ca-certificates curl -y
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt install kubelet kubeadm kubectl -y
sudo apt-mark hold kubelet kubeadm kubectl
sudo swapoff -a
sudo sed -i 's/.*swap.*/#&/' /etc/fstab
sudo bash -c "cat > /etc/docker/daemon.json" <<EOF
{
    "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl restart kubelet

sudo sysctl net.bridge.bridge-nf-call-iptables=1
echo -e "\n################################################### Worker Finished ###################################################\n";
echo -e "\n!!!!!!!!!! Now can use token to add in kubernetes cluster, please add 'sudo' before token command !!!!!!!!!!\n";
