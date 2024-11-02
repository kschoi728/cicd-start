# https://hub.docker.com/r/linuxserver/code-server
FROM linuxserver/code-server:4.93.1

# ENV for Code-server (VSCode)
ENV TZ="Asia/Seoul"
ENV PUID=0
ENV PGID=1000

# Make DIR for code-server
RUN mkdir /code && chown 1000:1000 /code

# Update & Install the packages
RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y ca-certificates curl gnupg software-properties-common wget unzip apt-transport-https telnet net-tools vim iputils-ping openjdk-11-jdk python3 python3-pip gh

# Install Jupyter
RUN pip install --no-cache-dir --break-system-packages jupyter ipykernel

# ENV for JDK
ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Docker CLI
RUN apt-get update && install -m 0755 -d /etc/apt/keyrings  \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc  \
    && chmod a+r /etc/apt/keyrings/docker.asc

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && apt-get install -y docker-ce docker-ce-cli

# Install AWS CLI from `amazon/aws-cli` image
COPY --from=amazon/aws-cli /usr/local/aws-cli/v2 /usr/local/aws-cli/v2
RUN ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/local/bin/aws
RUN ln -s /usr/local/aws-cli/v2/current/bin/aws_completer /usr/local/bin/aws_completer

# Terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null  \
    && gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint  \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

# RUN apt update && apt-get install -y terraform=1.9.7
# RUN apt update && apt-get install -y terraform
RUN apt update && apt-get install -y terraform

# Kubectl
RUN curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.4/2024-09-11/bin/linux/amd64/kubectl && chmod +x ./kubectl && mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH

#RUN apt-get update && apt-get install -y kubectl

# Kubectx & Kubens
RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx  \
    && ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx  \
    && ln -s /opt/kubectx/kubens /usr/local/bin/kubens