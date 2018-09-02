#!/bin/sh
docker volume create pdrudata
docker run --rm --name pdru -d \
        -h pdru \
	--env-file=beyondbroadcast.com.secret \
        -v pdrudata:/etc/rspamd/local.d \
        siuyin/pdru
