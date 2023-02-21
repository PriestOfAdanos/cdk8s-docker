FROM python:3.11-alpine

RUN apk --no-cache add yarn npm git
RUN yarn global add cdk8s-cli && yarn cache clean
RUN mkdir /files 
WORKDIR /files
RUN pip install pipenv cdk8s-plus-25
RUN curl -sL https://raw.githubusercontent.com/crossplane/crossplane/release-1.0/install.sh | sh
RUN mv kubectl-crossplane /usr/local/bin
RUN curl -fsSL https://get.pulumi.com | sh
RUN /root/.pulumi/bin/pulumi plugin install resource kubernetes v3.0.0
RUN curl -i https://github.com/pulumi/kube2pulumi/releases/download/v0.0.12/kube2pulumi-v0.0.12-darwin-amd64.tar.gz -o kube2pulumi.tar.gz
ADD entrypoint.sh /entrypoint.sh
CMD ["/bin/sh"]
