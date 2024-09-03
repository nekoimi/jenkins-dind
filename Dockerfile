# debian 12 bookworm
FROM jenkins/jenkins:lts-jdk17

LABEL maintainer="nekoimi <nekoimime@gmail.com>"

USER root

RUN set -ex \
    && cat /etc/os-release \
#    && if [ -f /etc/apt/sources.list ]; then \
#         sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list; \
#        fi \
#    && if [ -f /etc/apt/sources.list.d/debian.sources ]; then \
#         sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources; \
#        fi \
    && apt-get update

RUN set -ex \
    && apt-get install -y ca-certificates curl \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc

RUN echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN set -ex \
    && apt-get update \
    && apt-get -y install docker-ce

RUN apt-get clean && usermod -aG docker jenkins

USER jenkins
