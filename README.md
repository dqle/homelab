## Pre-Req

4 Nodes Setup with Ubuntu Server LTS Minimalized (Proxmox)

Node Settings:
```
<DHCP>         - K3S-BOOTSTRAP  - 2 cores 4GB RAM
192.168.50.240 - K3S-MASTER     - 4 cores 16GB RAM
192.168.50.241 - K3S-WORKER-01  - 4 cores 36GB RAM
192.168.50.242 - K3S-WORKER-02  - 4 cores 36GB RAM
```

## All Nodes

```bash
sudo apt-get install vim
sudo visudo

#add to bottom
dqle ALL=(ALL) NOPASSWD: ALL
```

## Bootstrap Nodes

```bash
# Get k3sup
curl -sLS https://get.k3sup.dev | sh
sudo install k3sup /usr/local/bin/

#create ssh key (all default)
ssh-keygen -t rsa

#add ssh key to other nodes
ssh-copy-id dqle@192.168.50.240
ssh-copy-id dqle@192.168.50.241
ssh-copy-id dqle@192.168.50.242

#Install K3s MASTER:
k3sup install --cluster --host 192.168.50.240 --user dqle --k3s-extra-args "--disable traefik --disable servicelb --node-ip=192.168.50.240" --k3s-channel stable

#Install K3s WORKER-01:
k3sup join --server-ip 192.168.50.240 --ip 192.168.50.241 --user dqle --k3s-channel stable

#Install K3s WORKER-02:
k3sup join --server-ip 192.168.50.240 --ip 192.168.50.242 --user dqle --k3s-channel stable

#Label nodes
kubectl label node k3s-worker-01 node-role.kubernetes.io/worker=worker
kubectl label node k3s-worker-02 node-role.kubernetes.io/worker=worker
```

## Get Kubeconfig

```bash
cat /home/dqle/kubeconfig

#Copy output and put it on your management computer
#Windows location:  %USERNAME%/.kube/config
#Google Drive (Backup states and use for provider): "G:\My Drive\Terraform\kubeconfig"
```

