rm -rf /home/phoenix/token
kubeadm token create

# 토큰 목록에서 원하는 토큰 추출한 토큰을 토큰 파일에 작성 
touch /home/phoenix/token/token.txt
echo $(kubeadm token list | awk 'NR==2{print $1}') >> /home/phoenix/token/token.txt

# CA 인증서를 사용하여 퍼블릭 키의 SHA256 해시 생성 
echo $(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //') >> /home/phoenix/token/token.txt


# 토큰을 worker로 복사 
apt install -y expect

expect << EOF
spawn scp -o "StrictHostKeyChecking=no" /home/phoenix/token/token.txt phoenix@20.20.50.3:/home/phoenix/token.txt
expect "password:" {send "VMware1!\r"}
expect eof

spawn scp -o "StrictHostKeyChecking=no" /home/phoenix/token/token.txt phoenix@20.20.50.4:/home/phoenix/token.txt
expect "password:" {send "VMware1!\r"}
expect eof

spawn scp -o "StrictHostKeyChecking=no" /home/phoenix/token/token.txt phoenix@20.20.50.5:/home/phoenix/token.txt
expect "password:" {send "VMware1!\r"}
expect eof
EOF
