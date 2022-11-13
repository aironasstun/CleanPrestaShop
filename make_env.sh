#!/bin/sh

#remove tmp files/folders
unlink .env
rm -r var/

#Appropriate.If you can create env, you don't have to use it
touch .env
echo "UID=$(id -u $USER)" >> .env
echo "GID=$(id -g $USER)" >> .env
echo "UNAME=$USER" >> .env

...
RUN useradd gunter #Each user name should be cool
RUN USER=gunter && \
    GROUP=gunter && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.5/fixuid-0.5-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml
#So far root user
#gunter user from here
USER gunter:gunter

ENTRYPOINT[ "fixuid" ]

docker-compose up --build --force-recreate