FROM python:3.11-alpine

RUN apk --no-cache add yarn npm git curl go
RUN yarn global add cdk8s-cli && yarn cache clean
RUN mkdir /files 
WORKDIR /files
RUN pip install pipenv cdk8s-plus-25
RUN curl -sL https://raw.githubusercontent.com/crossplane/crossplane/release-1.0/install.sh | sh
 # install curl
# install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# Install vCluster
RUN curl -L -o vcluster "https://github.com/loft-sh/vcluster/releases/download/v0.13.0/vcluster-linux-amd64" && install -c -m 0755 vcluster /usr/local/bin && rm -f vcluster
# Install Helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# RUN mv kubectl-crossplane /usr/local/bin
RUN curl -fsSL https://get.pulumi.com | sh
RUN /root/.pulumi/bin/pulumi plugin install resource kubernetes v3.0.0
RUN curl -i https://github.com/pulumi/kube2pulumi/releases/download/v0.0.12/kube2pulumi-v0.0.12-darwin-amd64.tar.gz -o kube2pulumi.tar.gz
ADD entrypoint.sh /entrypoint.sh
CMD ["/bin/sh"]
