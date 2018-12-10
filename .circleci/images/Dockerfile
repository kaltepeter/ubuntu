FROM ubuntu:18.04

ARG VERSION=$TAG

RUN echo "postfix postfix/mailname string example.com" | debconf-set-selections && \
    echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections && \
    echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install \
    wget \
    gnupg \
    postfix \
    vim \
    apt-transport-https && \
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add - && \
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add - && \
    apt-get -y install software-properties-common && \
    apt-add-repository 'deb https://download.virtualbox.org/virtualbox/debian bionic contrib'

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yf install --install-suggests virtualbox-5.2

RUN wget -q https://download.virtualbox.org/virtualbox/5.2.22/Oracle_VM_VirtualBox_Extension_Pack-5.2.22.vbox-extpack -O Oracle_VM_VirtualBox_Extension_Pack-5.2.22.vbox-extpack && \
    echo "y" | VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.2.22.vbox-extpack && \
    rm Oracle_VM_VirtualBox_Extension_Pack-5.2.22.vbox-extpack


RUN wget -q https://releases.hashicorp.com/packer/1.3.3/packer_1.3.3_linux_amd64.zip -O packer_1.3.3_linux_amd64.zip && \
    unzip packer_1.3.3_linux_amd64.zip -d /bin && rm packer_1.3.3_linux_amd64.zip

RUN /sbin/vboxconfig

ENTRYPOINT ["/bin/packer"]