FROM phusion/baseimage:0.11
RUN apt update && apt --no-install-recommends install -y postfix dovecot-core dovecot-imapd dovecot-lmtpd dovecot-sieve dovecot-managesieved unbound redis-server lsb-release wget && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN export CODENAME=`lsb_release -c -s` && wget -O- https://rspamd.com/apt-stable/gpg.key | apt-key add - && echo "deb [arch=amd64] http://rspamd.com/apt-stable/ $CODENAME main" > /etc/apt/sources.list.d/rspamd.list && echo "deb-src [arch=amd64] http://rspamd.com/apt-stable/ $CODENAME main" >> /etc/apt/sources.list.d/rspamd.list && apt update && apt --no-install-recommends install -y rspamd && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/sbin/my_init"]
