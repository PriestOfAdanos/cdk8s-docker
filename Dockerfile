FROM python:3.11-alpine

RUN apk --no-cache add yarn npm git
RUN yarn global add cdk8s-cli && yarn cache clean
RUN mkdir /files 
WORKDIR /files
RUN pip install pipenv cdk8s-plus-25
RUN curl -sL https://raw.githubusercontent.com/crossplane/crossplane/release-1.0/install.sh | sh
RUN mv kubectl-crossplane /usr/local/bin
ADD entrypoint.sh /entrypoint.sh
CMD ["/bin/sh"]
