FROM 492865049799.dkr.ecr.us-east-1.amazonaws.com/quovo-python3:1.0.1

ENV PYPICLOUD_VERSION 1.1.11

EXPOSE 8080

COPY . /opt/quovo-pypi
WORKDIR /opt/quovo-pypi 

# Install packages required
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -qy python3-pip \
     python3-dev libldap2-dev libsasl2-dev default-libmysqlclient-dev libffi-dev libssl-dev \
  && pip3 install -e . \
  && pip3 install -e .[ldap] \
  && pip3 install requests uwsgi \
     pastescript mysqlclient psycopg2-binary redis \
  # Create the pypicloud user
  && groupadd -r pypicloud \
  && useradd -r -g pypicloud -d /var/lib/pypicloud -m pypicloud

# Add the startup service
ADD pypicloud-uwsgi.sh /etc/my_init.d/pypicloud-uwsgi.sh

# Add the pypicloud config file
RUN mkdir -p /etc/pypicloud
ADD config.ini /etc/pypicloud/config.ini

# Create a working directory for pypicloud
VOLUME /var/lib/pypicloud

# Add the command for easily creating config files
ADD make-config.sh /usr/local/bin/make-config

# Add an environment variable that pypicloud-uwsgi.sh uses to determine which
# user to run as
ENV UWSGI_USER pypicloud

ENTRYPOINT ["/docker-entrypoint.sh"]
