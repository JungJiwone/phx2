# docker package apt-key download and add
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add

# set docker key
apt-key fingerprint OEBFCD88

# docker repository add and update
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update

# docker package install
#apt install docker-ce docker-ce-cli containerd.io -y
apt install -y docker-* containerd.io

# docker daemon start and enable
systemctl enable docker
systemctl start docker
