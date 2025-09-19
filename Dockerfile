ARG base=python:3.13-trixie
FROM ${base}
ARG base=python:3.13-trixie

RUN apt update; apt install -y vim bash-completion git make screen; \
    echo "set mouse-=a" > /root/.vimrc

ARG ver=v2.28.1
WORKDIR /opt/kubespray
RUN git clone https://github.com/kubernetes-sigs/kubespray.git  .; \
    git checkout ${ver} -b ${ver}; \
    pip install -r requirements.txt

# export kubeconfig.yaml into ops node.
RUN sed -i -E 's/# (kubeconfig_.*): false/\1: true/g' `find inventory/sample -type f`; \
    sed -i -E 's/# (kubectl_.*): false/\1: true/g'    `find inventory/sample -type f`;

VOLUME /opt/kubespray/inventory
