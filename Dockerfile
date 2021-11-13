FROM mcr.microsoft.com/powershell:7.2.0-ubuntu-20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV ENV TZ=America/Los_Angeles

# install aws cli
RUN apt-get update
RUN apt-get install curl git unzip groff -y
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
RUN rm awscliv2.zip

# install docker cli
RUN curl "https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz" -o docker.tgz
RUN tar xzvf docker.tgz --strip 1 -C /usr/local/bin docker/docker;
RUN rm docker.tgz

# install aws powershell module as well just in case you want to interface with aws that way instead.
RUN pwsh -C 'install-module -name awspowershell.netcore -force'
COPY ./powershellProfile.ps1 /root/.config/powershell/Microsoft.PowerShell_profile.ps1
