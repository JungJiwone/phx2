# join to master
token=$(sed -n '1p' /home/phoenix/token.txt)
sha256=$(sed -n '2p' /home/phoenix/token.txt)

kubeadm join 20.20.50.2:6443 --token $token --discovery-token-ca-cert-hash sha256:$sha256
