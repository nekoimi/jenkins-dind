# debian 11 bullseye
FROM jenkins/jenkins:2.391-jdk11

LABEL maintainer="nekoimi <nekoimime@gmail.com>"

USER root

RUN echo \
    "deb https://mirrors.aliyun.com/debian/ bullseye main non-free contrib \
     deb-src https://mirrors.aliyun.com/debian/ bullseye main non-free contrib \
     deb https://mirrors.aliyun.com/debian-security/ bullseye-security main \
     deb-src https://mirrors.aliyun.com/debian-security/ bullseye-security main \
     deb https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib \
     deb-src https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib \
     deb https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib \
     deb-src https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib \
    " > /etc/apt/sources.list

RUN set -ex \
    && apt-get update \
    && apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN set -ex \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN set -ex \
    && apt-get update \
    && apt-get -y install docker-ce=5:20.10.22~3-0~debian-bullseye
RUN apt-get clean && usermod -aG docker jenkins

USER jenkins
