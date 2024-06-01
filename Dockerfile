# debian 11 bullseye
FROM jenkins/jenkins:lts-jdk17

LABEL maintainer="nekoimi <nekoimime@gmail.com>"

USER root

RUN set -ex \
    && cat /etc/os-release \
    && sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources \
    && apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common

RUN set -ex \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable" \

RUN set -ex \
    && apt-get update \
    && apt-get -y install docker-ce

RUN apt-get clean && usermod -aG docker jenkins

USER jenkins
