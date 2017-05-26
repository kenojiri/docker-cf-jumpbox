FROM ubuntu:xenial

RUN apt-get update &&\
    apt-get install -y wget curl git jq

### CF CLI ###
RUN wget "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" -O /cf.tgz &&\
    tar zxvf /cf.tgz cf &&\
    install -m 755 /cf /usr/local/bin/ &&\
    rm /cf.tgz /cf

### BOSH CLI v2 ###
RUN apt-get install -y build-essential zlibc zlib1g-dev libssl-dev libreadline-dev
RUN curl -vL https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-`curl -s https://api.github.com/repos/cloudfoundry/bosh-cli/releases/latest | jq -r .name | tr -d 'v'`-linux-amd64 -o /usr/local/bin/bosh2 &&\
    chmod +x /usr/local/bin/bosh2

### Ruby ###
WORKDIR /root
RUN git clone https://github.com/riywo/anyenv $HOME/.anyenv &&\
    echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> $HOME/.profile &&\
    echo 'eval "$(anyenv init -)"' >> $HOME/.profile &&\
    . $HOME/.profile &&\
    anyenv install rbenv &&\
    . $HOME/.profile &&\
    rbenv install 2.4.1 &&\
    rbenv global 2.4.1 &&\
    gem install bundler --no-ri --no-rdoc

### UAA CLI ###
RUN . $HOME/.profile &&\
    gem install cf-uaac --no-ri --no-rdoc

### BOSH CLI v1, bosh-init ###
RUN . $HOME/.profile &&\
    gem install bosh_cli --no-ri --no-rdoc &&\
    curl -vL https://s3.amazonaws.com/bosh-init-artifacts/bosh-init-`curl -s https://api.github.com/repos/cloudfoundry/bosh-init/releases/latest | jq -r .name | tr -d 'v'`-linux-amd64 -o /usr/local/bin/bosh-init &&\
    chmod +x /usr/local/bin/bosh-init

### Concourse CLI ###
#TODO

### spruce ###
#TODO

### CF CLI plugins ###
RUN cf install-plugin -f -r CF-Community update-cli

### additional tools ###
RUN apt-get install -y vim tmux

ENTRYPOINT ["/bin/bash", "--login"]
