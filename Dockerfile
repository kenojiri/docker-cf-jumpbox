FROM ubuntu:xenial

RUN apt-get update &&\
    apt-get install -y \
      wget curl git jq zip ruby \
      vim tmux tree pwgen direnv bash-completion

### BOSH CLI v2 ###
RUN apt-get install -y build-essential zlibc zlib1g-dev libssl-dev libreadline-dev
RUN curl -vL https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-`curl -s https://api.github.com/repos/cloudfoundry/bosh-cli/releases/latest | jq -r .name | tr -d 'v'`-linux-amd64 -o /usr/local/bin/bosh &&\
    chmod +x /usr/local/bin/bosh

### CF CLI ###
RUN apt-get install -y apt-transport-https &&\
    wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - &&\
    echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list &&\
    apt-get update &&\
    apt-get install -y cf-cli &&\
    curl https://raw.githubusercontent.com/cloudfoundry/cli/master/ci/installers/completion/cf -o /usr/share/bash-completion/completions/cf

### CF CLI plugins ###
RUN cf install-plugin -f -r CF-Community update-cli

### UAA CLI ###
RUN apt-get install -y ruby-dev &&\
    gem install cf-uaac

### CredHub CLI ###
RUN export VERSION=$(curl -s https://api.github.com/repos/cloudfoundry-incubator/credhub-cli/releases/latest | jq -r .tag_name) &&\
    curl -vL https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/$VERSION/credhub-linux-$VERSION.tgz | tar zxvf - &&\
    cp ./credhub /usr/local/bin/ &&\
    rm ./credhub

### Concourse CLI ###
RUN curl -vL https://github.com/concourse/concourse/releases/download/`curl -s https://api.github.com/repos/concourse/concourse/releases/latest | jq -r .tag_name`/fly_linux_amd64 -o /usr/local/bin/fly &&\
    chmod +x /usr/local/bin/fly

### Minio CLI ###
RUN curl -vL https://dl.minio.io/client/mc/release/linux-amd64/mc -o /usr/local/bin/mc &&\
    chmod +x /usr/local/bin/mc

### HashiCorp Terraform ###
RUN export VERSION=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | jq -r .tag_name | sed 's/v//'` &&\
    curl -vL https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip -o /tmp/terraform.zip &&\
    cd /usr/local/bin &&\
    unzip /tmp/terraform.zip &&\
    rm /tmp/terraform.zip

### Kubernetes CLI (kubectl) ###
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl &&\
    chmod +x ./kubectl &&\
    cp ./kubectl /usr/local/bin/ &&\
    rm ./kubectl

### HashiCorp Vault ###
RUN export VERSION=`curl -s https://api.github.com/repos/hashicorp/vault/tags | jq -r '.[0] | ."name"' | sed 's/v//'` &&\
    curl -vL https://releases.hashicorp.com/vault/${VERSION}/vault_${VERSION}_linux_amd64.zip -o /tmp/vault.zip &&\
    cd /usr/local/bin &&\
    unzip /tmp/vault.zip &&\
    rm /tmp/vault.zip

### gotty ###
RUN curl -vL https://github.com/yudai/gotty/releases/download/`curl -s https://api.github.com/repos/yudai/gotty/releases/latest | jq -r .tag_name`/gotty_linux_amd64.tar.gz | tar zxvf - &&\
    cp ./gotty /usr/local/bin/ &&\
    rm ./gotty

### create workspace directory ###
RUN mkdir /work
WORKDIR /work

### create user/group ###
RUN useradd -u 1000 -U -m user
USER 1000:1000
COPY _bash_profile /home/user/.bash_profile

CMD ["/bin/bash", "--login"]
