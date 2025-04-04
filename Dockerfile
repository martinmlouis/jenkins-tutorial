FROM ubuntu

RUN apt update \
&& apt install curl gpg wget sudo -y

RUN curl -sL https://aka.ms/InstallAzureCLIDeb |  bash

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null \
&& apt update && apt install packer -y \
&& apt update && apt install terraform -y
