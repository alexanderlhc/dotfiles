#!/usr/bin/env bash
set -euo pipefail
USER="alexanderlhc@disroot.org"
HOST="disroot.org"
PASS="$(pass show email/personal | head -n 1)"
python3 - <<PY
import imaplib
user = "${USER}"
host = "${HOST}"
password = "${PASS}"
imap = imaplib.IMAP4_SSL(host)
imap.login(user, password)
typ, data = imap.status("INBOX", "(UNSEEN)")
if typ != "OK":
    total = 0
else:
    s = data[0].decode()
    total = int(s.split("UNSEEN")[1].split(")")[0].strip())
imap.logout()
if total > 0:
    print(f'{{"text":"  {total}","tooltip":"Unread: {total}"}}')
else:
    print('{"text":"","tooltip":"Unread: 0"}')
PY
