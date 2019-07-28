FROM 492865049799.dkr.ecr.us-east-1.amazonaws.com/quovo-python3:1.0.1

RUN addgroup --system --gid 9898 pypiserver \
    && adduser --system -u 9898 --gid 9898 pypiserver \
    && mkdir -p /data/packages \
    && touch /data/htaccess \ 
    && chown -R pypiserver:pypiserver /data/packages \
    && chmod -R 760 /data/packages

RUN apt-get update -qq \
    && apt-get install -y python3-pip \ 
    && pip3 install pypiserver passlib

ADD ./entrypoint.sh /data/entrypoint.sh
RUN chmod ug+x /data/entrypoint.sh 

EXPOSE 8080
USER pypiserver
VOLUME /data/packages
WORKDIR /data 

CMD ["/data/entrypoint.sh"]
