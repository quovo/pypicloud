envsubst < /etc/pypicloud/config.ini > /var/lib/pypicloud/config.ini
uwsgi --die-on-term /var/lib/pypicloud/config.ini