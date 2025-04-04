FROM ubuntu

RUN apt update \
&& apt install curl gpg wget sudo -y

RUN curl -sL https://aka.ms/InstallAzureCLIDeb |  bash

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null \
&& apt update && apt install packer -y \
&& apt update && apt install terraform -y

#RUN echo "test"

#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AA16FCBCA621E701 \
#&& apt update \
#&& wget -O temp.gpg https://apt.releases.hashicorp.com/gpg \
#&& gpg --dearmor temp.gpg \
#&& tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null <temp.gpg \
#&& rm temp.gpg \
#&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" >> /etc/apt/sources.list.d/hashicorp.list \
#&& apt update && apt install packer -y

#RUN wget -O temp_gpg https://apt.releases.hashicorp.com/gpg \
#&& cat temp_gpg | gpg --batch --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
#&& rm temp_gpg \
#&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" >> /etc/apt/sources.list.d/hashicorp.list \
#&& apt update && apt install terraform -y
