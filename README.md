# jumpbox on Docker for Cloud Foundry

![Docker automated build](https://img.shields.io/docker/automated/ozzozz/cf-jumpbox.svg)

inspired by [jumpbox-boshrelease](https://github.com/cloudfoundry-community/jumpbox-boshrelease).

## to get BASH shell prompt

```
$ docker run -it --rm -v $PWD:/work ozzozz/cf-jumpbox
```

## commands you can run

* cf [(Cloud Foundry CLI)](https://github.com/cloudfoundry/cli)
  * `cf update-cli` available
* bosh [(BOSH CLI v2)](https://bosh.io/docs/cli-v2.html)
* uaac [(UAA CLI)](https://github.com/cloudfoundry/cf-uaac)
* fly [(Concourse CLI)](https://concourse.ci/fly-cli.html)
* mc [(Minio CLI)](https://docs.minio.io/docs/minio-client-quickstart-guide)
* wget
* curl
* git
* jq
* zip
  * unzip
* ruby
  * bundle
* vim
* tmux
* tree
* pwgen
