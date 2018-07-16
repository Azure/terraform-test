FROM ruby:2.3
ARG tfver
ENV TERRAFORM_VERSION=$tfver

COPY ["Gemfile", "Rakefile", "/tf-test/"]
COPY build/ /tf-test/build/
RUN apt-get update && gem update --system && apt-get install unzip \
    && curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS \
    && curl https://keybase.io/hashicorp/pgp_keys.asc | gpg --import \
    && curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig \
    && gpg --verify terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig terraform_${TERRAFORM_VERSION}_SHA256SUMS \
    && shasum -a 256 -c terraform_${TERRAFORM_VERSION}_SHA256SUMS 2>&1 | grep "${TERRAFORM_VERSION}_linux_amd64.zip:\sOK" \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin

WORKDIR /tf-test/
RUN gem install rake --version =12.3.0 \
    && gem install colorize --version =0.8.1 \
    && gem install rspec --version =3.7.0 \
    && gem install kitchen-terraform --version 3.0.0 \
    && gem install test-kitchen --version 1.16.0
WORKDIR /tf-test/module

RUN wget https://storage.googleapis.com/golang/go1.10.3.linux-amd64.tar.gz >/dev/null 2>&1
RUN tar -zxvf go1.10.3.linux-amd64.tar.gz -C /usr/local/ >/dev/null
ENV PATH /usr/local/go/bin:/usr/local/bin:/usr/bin:$PATH

# RUN /bin/bash -c "go get -u github.com/denisenkom/go-mssqldb"
# RUN /bin/bash -c "go get github.com/stretchr/testify/assert"
# RUN /bin/bash -c "go get github.com/gruntwork-io/terratest/modules/ssh"
# RUN /bin/bash -c "go get github.com/gruntwork-io/terratest/modules/retry"
# RUN /bin/bash -c "go get github.com/gruntwork-io/terratest/modules/random"
# RUN /bin/bash -c "go get github.com/gruntwork-io/terratest/modules/terraform"
# RUN /bin/bash -c "go get github.com/gruntwork-io/terratest/modules/http-helper"
# RUN /bin/bash -c "go get github.com/gruntwork-io/terratest/modules/test-structure"