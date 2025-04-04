FROM ubuntu

RUN apt update \
&& apt install curl gpg wget -y

RUN curl -sL https://aka.ms/InstallAzureCLIDeb |  bash

RUN wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor --batch -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" >> /etc/apt/sources.list.d/hashicorp.list \
&& apt update && apt install packer -y

RUN wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor --batch -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" >> /etc/apt/sources.list.d/hashicorp.list \
&& apt update && apt install terraform -y
