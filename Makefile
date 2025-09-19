wDir=${PWD}
dDir=${wDir}/inventory
clName=mine
baseCluster=sample

v    ?=v2.28.1
img  ?=itaru2622/kubespray:${v}-trixie
base ?=python:3.13-trixie

build:
	docker build --build-arg base=${base} --build-arg ver=${v} -t ${img} .

bash:
	docker run -it --rm \
        -v ${wDir}/Makefile:/opt/kubespray/Makefile \
        -v ${dDir}:/opt/kubespray/inventory/${clName} \
	${img} /bin/bash

# ops in container
#
# create Cluster
create: inventory/${clName}/group_vars
	ansible-playbook -i inventory/${clName}/inventory.ini --private-key inventory/${clName}/ssh-key \
	--become --become-user=root -v \
	cluster.yml

# add node to Cluster
addNode:
	ansible-playbook -i inventory/${clName}/inventory.ini --private-key inventory/${clName}/ssh-key \
	--become --become-user=root -v \
	scale.yml

# remove node to Cluster
rmNode:
	ansible-playbook -i inventory/${clName}/inventory.ini --private-key inventory/${clName}/ssh-key \
	--become --become-user=root -v \
	remove-node.yml --extra-vars "node=${node}"

# delete Cluster
purge:
	ansible-playbook -i inventory/${clName}/inventory.ini --private-key inventory/${clName}/ssh-key \
	--become --become-user=root -v \
	reset.yml

upgrade:
	ansible-playbook -i inventory/${clName}/inventory.ini --private-key inventory/${clName}/ssh-key \
	--become --become-user=root -v \
	upgrade-cluster.yml

inventory/${clName}/group_vars:
	@echo "########## needs inventry files...########## "
	cp -pr inventory/${baseCluster}/group_vars inventory/${clName}/
	@echo "########## files copied.  ########## "
