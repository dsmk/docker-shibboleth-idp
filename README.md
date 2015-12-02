## Overview
This Docker image contains a deployed Shibboleth IdP 3.2.0 running on 
Java Runtime 1.8 update 60 and Jetty 9.3.6 running on the latest CentOS 7 base.

This image can be used as a base image overriding the configuration with local changes, or as an appliance and used directly by using a local configuration.

Jetty has been configured to use setuid and http traffic is handled by a non-root user. This version is only using port 443 for traffic as Boston University is not using
SOAP endpoints.

> This image requires acceptance of the Java License Agreement (<http://www.oracle.com/technetwork/java/javase/terms/license/index.html>).

## Notes
This docker image is built up>on jtgasper3's IdP v3 docker work:

https://github.com/jtgasper3/docker-shibboleth-idp


https://github.com/Unicon/shibboleth-idp-dockerized

And available in the Docker Hub at:

https://hub.docker.com/r/unicon/shibboleth-idp/

#### Starting the container

The shell script run-cmd.sh has the common starting parameters.

```
$ ./run-cmd.sh
```
In addition, one can still run the individual commands similar to how jtgasper3's
version worked.

```
$ docker run -dP --name="idp-test" -v ~/docker/shib-config:/external-mount jtgasper3/shibboleth-idp 
```

> If you do not have an existing configuration to import, after starting the container you **must** run:   
> `$ docker exec -it idp-test reset-idp.sh`   
> **Otherwise you will be running with a well-known (unsafe) encryption/signing key.** (Be sure to restart the container to accept the new config.)


#### Importing an existing configuration
Update the Jetty/Shibboleth config by importing an existing configuration into a running container: 

```
$ docker exec idp-test import.sh

```
Stop the container and restart it to pick up changes.

#### Exporting the current configuration
Besure to export any changes and store them elsewhere. If a container is deleted before you export your config, signing/config keys will be losts.

```
$ docker exec idp-test export.sh

```

#### Misc Notes on Execution
The Shibboleth IdP logs can be explicitly mapped to local storage by adding `-v /local/path:/opt/shibboleth-idp/logs` when starting the container.

Other advance docker storage strategies are also possible.

## Container Settings

### Jetty's Maximum Heap Size Setting
By default this container will execute Jetty with a setting 512m for Java's Maximum Heap Size. This can be overridden by `run`ing the container using the `-e JETTY_MAX_HEAP` flag like so:

```
docker run -dP -e JETTY_MAX_HEAP=1g shibboleth-idp 
```

> All values must conform to java's -Xmx values.

## Building

There is a shell script to build the base package:

```
$ ./build-cmd.sh
```
It is a just a simple wrapper around the normal docker build commands:

```
$ docker build --tag="org_id/shibboleth-idp" github.com/jtgasper3/docker-shibboleth-idp
```

## Author

  * David King (<dsmk@bu.edu>)

## References
The following references provided some form of guidance for this project:

* https://github.com/jtgasper3/docker-shibboleth-idp
* https://github.com/Maluuba/docker-files/tree/master/docker-jetty
* https://registry.hub.docker.com/u/dockerfile/java/
* https://github.com/jfroche/docker-shibboleth-idp
* http://mrbluecoat.blogspot.com/2014/10/docker-traps-and-how-to-avoid-them.html

## LICENSE
(temporary)
Copyright 2015 David King

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
