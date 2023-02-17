FROM python:3.11-alpine

RUN apk --no-cache add yarn npm git
RUN yarn global add cdk8s-cli && yarn cache clean
RUN mkdir /files 
WORKDIR /files
RUN pip install pipenv

ADD entrypoint-python.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
