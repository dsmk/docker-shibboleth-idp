#!/bin/bash -x
#
# Simple shell script to install the IdP with our preferred options
#
shibidp_version="3.2.0"
pw_filename="/opt/sealer_pw"

# generate a randome password for the various sealers
if [ ! -f "$pw_filename" ]; then
  openssl rand -hex 32 >"$pw_filename"
fi
pw=$(cat "$pw_filename")

# download and extract the IdP software
wget https://shibboleth.net/downloads/identity-provider/$shibidp_version/shibboleth-identity-provider-$shibidp_version.zip \
&& echo "5d17a0626a83791830e5842357f30369142efe322a1fdcf7b24c832924dbb98b  shibboleth-identity-provider-$shibidp_version.zip" | sha256sum -c - \
&& unzip shibboleth-identity-provider-$shibidp_version.zip -d /opt 

# now run the installer with our generated password
cd /opt/shibboleth-identity-provider-$shibidp_version/ \
&& bin/install.sh -Didp.keystore.password=$pw -Didp.sealer.password=$pw -Didp.host.name=imp.bu.edu \
&& cd / \
&& chmod -R +r /opt/shibboleth-idp/ \
&& sed -i "s/ password/$pw/g" /opt/shibboleth-idp/conf/idp.properties \
&& rm -r /shibboleth-identity-provider-$shibidp_version.zip /opt/shibboleth-identity-provider-$shibidp_version/



