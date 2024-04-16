# PDRU - Postfix Dovecot Rspamd and Unbound

* Postfix is an Mail Transport Agent. It sends
  and receives mail.

* Dovecot is an imap mail server. It serves
  mail to Mail User Agents like thunderbird or mutt.

* Rspamd is a spam filter.

* Unbound is a recursive, caching name server.

## Postfix configuration
* /etc/postfix/virtual holds the mapping of a user to a server.  
For example:
```
/etc/postfixt/virtual:
a@example.com b@another.com
```
will have email destined for a@example.com forwarded to b@another.com .
The file is immutable within the container.
To actually update the mapping, change beyondbroadcast.com.secret

To test the postfix component:

```
EHLO beyondbroadcast.com
MAIL FROM:<siuyin@beyondbroadcast.com>
RCPT TO:<lsy@beyondbroadcast.com> NOTIFY=success,failure
DATA
Subject: t 1141
# press enter for blank line
This is a test.
.
QUIT
```

## Dovecot configuration
The above test email sends to the same domain.
If user lsy@beyondbroadcast.com exist,
then a Maildir will be created on the Dovecot imap server.

To test, point your imap client (eg. Thunderbird) to the imap server
to retrieve emails.
