FROM ubuntu:12.04.5

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y openssh-server cmake gcc && \
  apt-get install -y vim python tcpdump telnet && \
  apt-get install -y byacc flex && \
  apt-get install -y gdbserver less bison valgrind && \
  apt-get install -y curl git htop man unzip vim wget && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y python-software-properties && \
  mkdir /var/run/sshd && \
  echo 'root:root' | chpasswd && \
  sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  mkdir ~/tmp

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22 9999 7777
# RUN ["/usr/sbin/sshd", "-D"]
CMD ["/usr/sbin/sshd", "-D"]
# CMD ["/usr/bin/bash"]