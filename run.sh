#!/bin/bash

################################################################################
#                                                                              #
#                                 {o,o}                                        #
#                                 |)__)                                        #
#                                 -"-"-                                        #
#                                                                              #
################################################################################
#
#The start script for the jenkins slave container
#
##############################---VARIABLES---###################################

#This are the things you can set. Pass them to docker as enviormentals.
JENKINS_PASSWORD=${JENKINS_PASSWORD:-"jenkins"}
JENKINS_HOME=${JENKINS_HOME:-"/var/jenkins-home"}

#If by any chance someone wants to change the username, who am I to stop you :)
JENKINS_USERNAME=${JENKINS_NAME:-"jenkins"}
#String containing the authorized key(s) - you will need this
JENKINS_AUTHORIZED_KEYS=${JENKINS_AUTHORIZED_KEYS:-""}

################################################################################

##############################---FUNCTIONS---###################################

function setupJenkins() {
    if [ -z "$(grep "${JENKINS_USERNAME}" /etc/passwd)" ]
        then
        useradd \
            -d ${JENKINS_HOME} \
            -m \
            ${JENKINS_USERNAME}
        echo "${JENKINS_USERNAME}:${JENKINS_PASSWORD}" | chpasswd
    fi
}


function safetyCheck() {
    #Cleanup any enviormentals, we don't want this floating about.
    unset JENKINS_PASSWORD \
        JENKINS_HOME \
        JENKINS_USERNAME \
        JENKINS_AUTHORIZED_KEYS

    mkdir -p /var/run/sshd
    sed -i "/PasswordAuthentication /aPasswordAuthentication no" \
        /etc/ssh/sshd_config
}

################################################################################

###############################---EXECUTION---##################################

setupJenkins
safetyCheck

/usr/sbin/sshd -D

################################################################################
