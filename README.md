# Jenkins slave image

This image is meant to be used as a jenkins slave container. The ssh server
listens for Jenkins requests.

# Usage

* Basic usage

```
docker run \
    -d \
    --name jenkins-slave \
    --restart always \
    -e JENKINS_AUTHORIZED_KEYS="<public key of the jenkins master>" \
    -p <local port>:22 \
    kendu/jenkins-slave
```
replace the <> fields acordingly.

You can also set different username, password and working directory for
jenkins. Defaults are:

* JENKINS_PASSWORD = `jenkins`
* JENKINS_HOME = `/var/jenkins-home`
* JENKINS_USERNAME = `jenkins`

NOTE: Password authentication is disabled, so setting the authorized key is
 mandatory. This also makes changing username and password optional.
