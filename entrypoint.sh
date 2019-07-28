#!/bin/bash 

#Initialize pypiserver with htaccess password.
pypi-server -v -o -i 0.0.0.0 -p 8080 -P /data/htaccess /data/packages