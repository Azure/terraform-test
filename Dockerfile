FROM golang:1.10.4-alpine3.8

ENV TERRAFORM_VERSION=0.11.7-r0

RUN apk add terraform=$TERRAFORM_VERSION bash git

RUN /bin/bash -c "wget -O - https://raw.githubusercontent.com/golang/dep/master/install.sh | sh"

COPY ./azure-terraform-module-test.sh /bin/
RUN chmod 744 /bin/azure-terraform-module-test.sh

RUN mkdir -p /go/src/module
WORKDIR /go/src/module

ENTRYPOINT ["bash"]