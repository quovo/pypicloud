#!/bin/bash

# Pull SSL Certs for ldap
echo "Retrieving SSL Files from s3://quovo-ssl"
aws s3 cp ldap_ca_pem.crt s3://quovo-ssl/ /usr/local/share/ca-certificates/ldap_ca_pem.crt
if [ $? -ne 0 ]; then
  echo "ERROR: Unable to retrieve ssl files Skipping process. Verify that quovo-ssl bucket is accessible."
  exit 1
else
  update-ca-certificates
fi
echo "Starting uwsgi for pypicloud"
/sbin/setuser "$UWSGI_USER" uwsgi --die-on-term /etc/pypicloud/config.ini