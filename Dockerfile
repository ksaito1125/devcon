FROM ubuntu:18.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

# Install other package
RUN apt-get update && apt-get install -y \
    language-pack-ja tzdata \
    sudo keychain netcat-openbsd \
    command-not-found \
    tmux tmuxinator \
    direnv peco \
    jq nmap git-svn \
    emacs emacs-goodies-el vim \
    dstat \
    iproute2 net-tools dnsutils \
    golang \
    groff \
    bsdmainutils \
    bash-completion \
    lv \
    curl \
    python3-venv \
 && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*
RUN ln -f -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
# Install goss https://github.com/aelsabbahy/goss
RUN curl -fsSL https://goss.rocks/install | sh

# FROM base AS docker-base
# # Install docker-ce https://docs.docker.com/install/linux/docker-ce/ubuntu/
# RUN apt-get update && apt-get install -y \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     software-properties-common \
#  && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
#  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) edge" \
#  && apt-get update && apt-get install -y docker-ce-cli \
#  && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*
# # Install kubectl https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl
# RUN apt-get update && apt-get install -y \
#     apt-transport-https \
#  && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
#  && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
#  && apt-get update && apt-get install -y kubectl \
#  && kubectl completion bash > /etc/bash_completion.d/kubectl \
#  && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# FROM docker-base AS cloud-base
# # Install Google Cloud cli https://cloud.google.com/sdk/docs/downloads-apt-get
# ENV CLOUD_SDK_REPO="cloud-sdk-bionic"
# RUN echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
#  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
#  && apt-get update && apt-get install -y google-cloud-sdk \
#  && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*
# # Install aws cli https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-chap-install.html
# RUN apt-get update && apt-get install -y \
#     python-pip \
#  && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*
# # Install awscli
# RUN pip install awscli

# FROM base AS go112

# RUN wget https://dl.google.com/go/go1.12.7.linux-amd64.tar.gz \
#  && tar -xvf go1.12.7.linux-amd64.tar.gz
# ENV GOROOT=/go
# ENV PATH=$GOROOT/bin:$PATH
# # Install ghq https://github.com/motemen/ghq
# RUN go get github.com/motemen/ghq

# FROM cloud-base AS dev-base
# # Install git-secrets
# RUN curl -SL https://github.com/awslabs/git-secrets/archive/1.2.1.tar.gz \
#   | tar -xzC /tmp \
#  && make -C /tmp/git-secrets-1.2.1 install \
#  && rm -rf /tmp/git-secrets-1.2.1

ADD files/etc /etc

# FROM dev-base

# COPY --from=go112 /root/go/bin/ghq /usr/local/bin/ghq
# # upgrade
# #RUN apt-get update && apt-get upgrade -y

# # Test
# #RUN goss -g /util/goss.yaml validate
