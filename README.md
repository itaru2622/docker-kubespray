## docker-kubespray

## Reference:

- https://github.com/kubernetes-sigs/kubespray
- https://www.docswell.com/s/ponzmild/5NDVDK-scrap-and-build-k8s-with-kubespray
- https://qiita.com/irumaru/items/76c6a083e04a4ed6a119


## sample inventory.ini:

```
[all]
vm00 ansible_host=192.168.1.90    ip=192.168.1.90    etcd_member_name=etcd1     ansible_user=itaru2622

[kube_control_plane]
vm00

[etcd]
vm00

[kube_node]
vm00
```
