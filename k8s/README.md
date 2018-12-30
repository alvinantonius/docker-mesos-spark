Init the master IP

```
kubeadm init --apiserver-advertise-address=<master-ip> --apiserver-cert-extra-sans=<master-ip> --node-name $(hostname -s)
```

Set up for non root user

```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Installing a pod network add-on

```
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```

Join the node

```
kubeadm join 192.168.99.100:6443 --token <token> --discovery-token-ca-cert-hash <ca-hash>
```