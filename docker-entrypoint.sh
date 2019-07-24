#!/bin/bash

# Update local CA certs to trust quovo.local certificates
cp /etc/quovo/ssl/ldap_ca_pem.crt /usr/local/share/ca-certificates/ldap_ca_pem.crt
update-ca-certificates

echo "Starting uwsgi for pypicloud"
/sbin/setuser "$UWSGI_USER" uwsgi --die-on-term /etc/pypicloud/config.ini