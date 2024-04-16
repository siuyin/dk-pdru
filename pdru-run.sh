#!/bin/sh
docker volume create pdrudata
docker run --rm --name pdru -d \
        -h pdru \
        --env-file=beyondbroadcast.com.secret \
        -v pdrudata:/etc/rspamd/local.d \
        -v /home/siuyin/pdru/mail:/var/mail/domains \
        -v $(pwd)/go.beyondbroadcast.com/fullchain.pem:/etc/dovecot/private/dovecot.pem \
        -v $(pwd)/go.beyondbroadcast.com/privkey.pem:/etc/dovecot/private/dovecot.key \
        -p 25:25 \
        -p 143:143 \
        siuyin/pdru
