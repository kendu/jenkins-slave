#
#       .
#        ":"
#      ___:____     |"\/"|
#    ,'        `.    \  /
#    |  O        \___/  |
#  ~^~^~^~^~^~^~^~^~^~^~^~^~

#The docker slave image
FROM debian
MAINTAINER DevOps <devops@kendu.si>

# Do the packaging - (update, upgrade, install what we need, and clean up)
RUN apt-get update && \
    apt-get upgrade && \
    apt-get install \
        openssh-server \
        openjdk-7-jdk && \
    apt-get clean

#Add startup script
ADD run.sh /opt/app/run.sh

WORKDIR /opt/app

EXPOSE 22

CMD ./run.sh