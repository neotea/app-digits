#!/bin/sh

# http://docs.gunicorn.org/en/stable/settings.html

sudo service nginx start

cd /usr/share/digits

. /etc/JARVICE/jobinfo.sh

sed -i "s/{{hostname}}/${JOB_PUBLICADDR}/g" /usr/share/digits/digits/digits.cfg

mkdir -p /data/DIGITS/jobs

cd /usr/share/digits

gunicorn --certfile /etc/JARVICE/cert.pem --keyfile /etc/JARVICE/cert.pem --config gunicorn_config.py digits.webapp:app 2>&1 | tee -a /var/log/digits/digits.log
