#export KUBECONFIG="/etc/kubernetes/admin.conf"는 15.yml 돌리기 전에 마스터에서 작업해주기 

# k8s init
kubeadm init --pod-network-cidr=192.168.0.0/16

# docker 로그인 
echo "ahneunji" | docker login --username ahneunji --password "P@ssw0rd^^"

# 쿠버네티스에서 사용할 인증정보(secret) 생성 
kubectl create secret generic phoenix-secret --from-file=.dockerconfigjson=/root/.docker/config.json --type=kubernetes.io/dockerconfigjson

# calico CNI install
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/tigera-operator.yaml

# 커스텀 리소스를 클러스터에 생성  
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/custom-resources.yaml

# 토큰 디렉터리 생성 
mkdir -p /home/phoenix/token

# 토큰 목록에서 원하는 토큰 추출한 토큰을 토큰 파일에 작성 
touch /home/phoenix/token/token.txt
echo $(kubeadm token list | awk 'NR==2{print $1}') >> /home/phoenix/token/token.txt

# CA 인증서를 사용하여 퍼블릭 키의 SHA256 해시 생성  
echo $(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //') >> /home/phoenix/token/token.txt


# 토큰을 worker로 복사 
apt install -y expect

expect << EOF
spawn scp -o "StrictHostKeyChecking=no" /home/phoenix/token/token.txt phoenix@20.20.50.2:/home/phoenix/token.txt
expect "password:" {send "VMware1!\r"}
expect eof

spawn scp -o "StrictHostKeyChecking=no" /home/phoenix/token/token.txt phoenix@20.20.50.3:/home/phoenix/token.txt
expect "password:" {send "VMware1!\r"}
expect eof

spawn scp -o "StrictHostKeyChecking=no" /home/phoenix/token/token.txt phoenix@20.20.50.4:/home/phoenix/token.txt
expect "password:" {send "VMware1!\r"}
expect eof
EOF
