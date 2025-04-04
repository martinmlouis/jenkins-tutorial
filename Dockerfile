FROM ubuntu

RUN apt update \
&& apt install curl gpg wget -y

RUN curl -sL https://aka.ms/InstallAzureCLIDeb |  bash

RUN wget -O temp.gpg https://apt.releases.hashicorp.com/gpg \
&& gpg --dearmor temp.gpg \
&& tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null <temp.gpg 
&& rm temp.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" >> /etc/apt/sources.list.d/hashicorp.list \
&& apt update && apt install packer -y

RUN wget -O temp_gpg https://apt.releases.hashicorp.com/gpg \
&& cat temp_gpg | gpg --batch --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
&& rm temp_gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" >> /etc/apt/sources.list.d/hashicorp.list \
&& apt update && apt install terraform -y
