## docker-kubespray

## Reference:

- https://github.com/kubernetes-sigs/kubespray
- https://www.docswell.com/s/ponzmild/5NDVDK-scrap-and-build-k8s-with-kubespray
- https://qiita.com/irumaru/items/76c6a083e04a4ed6a119


## Requirements on target nodes to be setup with kubespray

- required softwares: gpg, openssh-server
- account to ssh login with ssh-key (private-key).


## sample inventory.ini:

```
[all]
vm00   ansible_host=192.168.1.90    ip=192.168.1.90    ansible_user=itaru2622     etcd_member_name=etcd1

[kube_control_plane]
vm00

[etcd]
vm00

[kube_node]
vm00
```

## Quick Start (simplest)

```bash
# configuration:
#  1) locate inventory.ini        into ./inventory folder (copy above sample as ./inventory/inventory.ini)
#  2) locate ssh private key      into ./inventory/ssh-key
#  3) optionally, configure parameters in ./inventory/group_vars folder based on https://github.com/kubernetes-sigs/kubespray/tree/master/inventory/sample/group_vars

# ----------------
# start container and enter into bash.
make bash

# ----------------
# create cluster
make create

# ----------------
# add Node to cluster
# 1) add nodes in ./inventory/inventory.ini
# 2) execute ops by below command.
make addNode

# ----------------
# remove Node from cluster
# 1) execute ops by below command.
# 2) optionaly: delete coresponding node from ./inventory/inventory.ini
make rmNode node=vm01

# ----------------
# purge cluster
make purge

```
