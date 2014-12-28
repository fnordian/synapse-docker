FROM ubuntu:14.04

# Set correct environment variables.
ENV HOME /root

EXPOSE 8008
EXPOSE 8448

RUN apt-get update

RUN apt-get install -y build-essential python2.7-dev libffi-dev python-pip python-setuptools sqlite3 libssl-dev
RUN pip install --user --process-dependency-links https://github.com/matrix-org/synapse/tarball/master

RUN mkdir /root/matrix
WORKDIR /root/matrix


RUN python -m synapse.app.homeserver -c /root/matrix/homeserver.yaml --generate-config --server-name=syndica.de

CMD /root/.local/bin/synctl start; sleep 2; tail -f /dev/null --pid `cat /root/matrix/homeserver.pid`


