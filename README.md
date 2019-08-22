# jumpbox on Docker for Cloud Foundry

[![Docker Pull Counter](https://img.shields.io/docker/pulls/ozzozz/cf-jumpbox.svg)](https://hub.docker.com/r/ozzozz/cf-jumpbox/)

inspired by [jumpbox-boshrelease](https://github.com/cloudfoundry-community/jumpbox-boshrelease).

## to get BASH shell prompt

```
$ docker run -it --rm -v $PWD:/work ozzozz/cf-jumpbox
```

## commands you can run

* cf [(Cloud Foundry CLI)](https://github.com/cloudfoundry/cli)
  * `cf update-cli` available
* bosh [(BOSH CLI v2)](https://bosh.io/docs/cli-v2.html)
* credhub [(CredHub CLI)](https://github.com/cloudfoundry-incubator/credhub-cli)
* kubectl [(Kubernetes CLI)](https://github.com/kubernetes/kubectl)
* [helm](https://github.com/kubernetes/helm)
* fly [(Concourse CLI)](https://concourse.ci/fly-cli.html)
* mc [(Minio CLI)](https://docs.minio.io/docs/minio-client-quickstart-guide)
* terraform [(HashiCorp Terraform)](https://www.terraform.io/)
* vault [(HashiCorp Vault)](https://www.vaultproject.io/)
* [usql](https://github.com/xo/usql)
* [gotty](https://github.com/yudai/gotty)
* wget
* curl
* git
* jq
* zip
  * unzip
* vim
* tmux
* tree
* pwgen
