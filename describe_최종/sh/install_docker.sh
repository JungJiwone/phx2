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

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# docker package apt-key download and add
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add

# set docker key
apt-key fingerprint OEBFCD88

# docker repository add and update
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update

# docker package install
# apt install docker-ce docker-ce-cli containerd.io -y
# docker 저장소 추가 : docker 패키지 설치하기 위해 docker 저장소를 추가합니다. 다음 명령을 사용하여 docker 저장소를 추가한다.
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 패지지 업데이트 : 패키지 목록을 업데이트하고 docker 설치
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io

# docker daemon start and enable
systemctl enable docker
systemctl start docker
