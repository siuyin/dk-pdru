FROM phusion/baseimage:0.11
RUN apt update && apt --no-install-recommends install -y postfix dovecot-core dovecot-imapd dovecot-lmtpd dovecot-sieve dovecot-managesieved unbound redis-server lsb-release wget iputils-ping netcat mutt && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN export CODENAME=`lsb_release -c -s` && wget -O- https://rspamd.com/apt-stable/gpg.key | apt-key add - && echo "deb [arch=amd64] http://rspamd.com/apt-stable/ $CODENAME main" > /etc/apt/sources.list.d/rspamd.list && echo "deb-src [arch=amd64] http://rspamd.com/apt-stable/ $CODENAME main" >> /etc/apt/sources.list.d/rspamd.list && apt update && apt --no-install-recommends install -y rspamd && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir -p /etc/service/postfix &&\
    mkdir -p /etc/service/dovecot &&\
    mkdir -p /etc/service/redis &&\
    mkdir -p /etc/service/rspamd &&\
    mkdir -p /etc/resolvconf/resolv.conf.d &&\
    mkdir -p /etc/service/unbound
# COPY service/postfix/run /etc/service/postfix/run
# COPY service/dovecot/run /etc/service/dovecot/run
# COPY service/redis/run /etc/service/redis/run
# COPY service/rspamd/run /etc/service/rspamd/run
# COPY service/unbound/run /etc/service/unbound/run
# COPY service/resolv/run /etc/service/resolv/run
COPY service/ /etc/service/
COPY postfix/main.cf /etc/postfix/main.cf
COPY unbound.conf /etc/unbound.conf
RUN chmod +x /etc/service/postfix/run &&\
    chmod +x /etc/service/dovecot/run &&\
    chmod +x /etc/service/redis/run &&\
    chmod +x /etc/service/rspamd/run &&\
    chmod +x /etc/service/resolv/run &&\
    chmod +x /etc/service/unbound/run
ENV DOMAINS='example.com example2.com' \
    VIRTUAL_ALIASES='info@example.com sales@example.com\nsales@example.com sales@example.com\n@example.com catchall@example.com' \
    VIRTUAL_MAILBOXES='sales@example.com example.com/sales\ncatchall@example.com example.com/catchall' \
    USERS='sales@example.com:{PLAIN}salespw::::::\ncatchall@example.com:{PLAIN}catchpass::::::'
VOLUME ["/etc/rspamd/local.d"]
CMD ["/sbin/my_init"]
