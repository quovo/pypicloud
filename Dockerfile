FROM 492865049799.dkr.ecr.us-east-1.amazonaws.com/quovo-python3:1.0.1

RUN mkdir -p /data/packages \
    && useradd pypiserver -r -d /data/packages \
    && chown -R pypiserver:pypiserver /data/packages \
    # Set the setgid bit so anything added here gets associated with the
    # pypiserver group
    && chmod g+s /data/packages 

RUN apt-get update -qq \
    && apt-get install -y python3-pip \ 
    && pip3 install pypiserver

EXPOSE 8080
VOLUME /data/packages
USER pypiserver
WORKDIR /data 

ENTRYPOINT ["pypi-server", "-p", "8080"]
CMD ["packages"]
