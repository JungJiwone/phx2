# swap disable
swapoff -a
free -m
sed -i '/swap/s/^/#/' /etc/fstab

# firewall disable
ufw disable

# lock prevent
rm -rf /var/lib/dpkg/lock-frontend
rm -rf /var/lib/dpkg/lock

# set network
echo "net.bridge.bridge-nf-call-iptables = 1" >> /etc/sysctl.d/k8s.conf
echo "tee /etc/sysctl.d/k8s.conf" >> /etc/modules-load.d/modules.conf
echo "br netfilter" >> /etc/modules-load.d/modules.conf

# Kubernetes public GPG key add
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# Kubernetes package store add
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

apt -y update

# k8s command install
apt install -y kubelet kubeadm kubectl

# k8s version fix
apt-mark hold kubelet kubeadm kubectl

# daemon restart
systemctl daemon-reload
systemctl restart kubelet

# docker directory create
mkdir /etc/docker

cat << EOF | tee /etc/docker/daemon.json
{
"exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"log-opts": {
"max-size": "100m"
},
"storage-driver": "overlay2"
}
EOF

# docker restart
systemctl daemon-reload
systemctl restart docker

# kubelet startm enable
systemctl start kubelet
systemctl enable kubelet

# containerd setting and restart
sed -i '/"cri"/ s/^/#/' /etc/containerd/config.toml
systemctl restart containerd
