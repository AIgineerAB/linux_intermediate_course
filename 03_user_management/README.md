# User management

<a href="" target="_blank">
  <img src="https://github.com/kokchun/assets/blob/main/FOLDER_NAME/.png?raw=true" alt="DESCRIPTION" width="600">
</a>

## /etc

/etc is a directory for system-wide configuration files that applies to all users of the system. These config files control behavior of operating system, services and softwares.

In this lecture we'll go into `/etc/passwd` but there are many more config files inside of /etc

## /etc/passwd

`/etc/passwd` is a system file containing information about user accounts and system services.

### Structure of a line (7 fields)

```bash
name:x:UID:GID:comment:home:shell

# example user
anna:x:1001:1001:Anna Svensson,,,:/home/anna:/bin/bash
```

1. username
2. password placeholder -
   1. x -> stored in /etc/shadow
3. UID - user id
   1. 0 for root
   2. 1-999 for system services
   3. \>=1000 for human users
4. GID - group id
   1. users primary group id
   2. details in /etc/group
5. GECOS/userinfo - commaseparated
6. Home directory
7. Login shell - path to when

### All users that can login

Run this to find all users that can login

```bash
grep -Ev '(nologin|false)$' /etc/passwd

root:x:0:0:Super User:/root:/bin/bash
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
kokchun:x:1000:1000:kokchun:/home/kokchun:/bin/bash
```

**root** is the superuser

- UID 0 -> superuser
- GID 0 -> root group
- home is /root
- shell is /bin/bash , which we can log in

**sync, shutdown, halt**

- shell is a command -> logging in runs the command

**kokchun**

- real user
- UID 1000 -> first regular user
- GIP 1000 -> personal group
- home is /home/kokchun
- shell is /bin/bash

## /etc/shadow

Hashed password lived originally inside of /etc/passwd, but /etc/passwd is world-reachable as many programs need to map UIDs to usernames such as `ls -l`. This is a security issue as you could take out the hashed password and brute force it.

The solution was to move it to /etc/shadow only readable by root and leave an x on the /etc/passwd to indicate there is a password to that user.

```bash
grep David /etc/passwd
# David:x:1000:1000:David:/home/David:/bin/bash
#       ^ "look in shadow"
```

David inside of shadow

```text
David:$y$j9T$kww41m0uAeUfxTdaeyDHU0$wdPLRsYT4zbSXUPUtdIJZl209rUpm4I0zKCDW8D8pb.:20716:0:99999:7:::
```

The stored field is as follows `user: $ hash algorithm $ parameter $ salt $ hash`. So the login flow is as follows:

1. type password
2. PAM (auth framework) calls pam_unix and checks the user in /etc/shadow
3. reads the field $ y $ j9T $ salt $ hash and knows it is yescript with parameter j9T with certain salt and hash.
4. Uses this information in 3 and hashes what we typed then checks it against stored hash. Hashing is one-way so the actual password is not decrypted.

## User management and passwd

```bash
# creates the user bob with a home directery
sudo useradd -m bob

# add a password
sudo passwd bob

# when bob is logged in as itself it can change the passwd
passwd

# if not logged in as bob and change his password
sudo passwd bob

# view password settings
sudo chage -l bob

# must change password every 90 days
sudo chage -M 90 bob

# can't change more often than at least 7 days
sudo chage -m 7 bob

# account dies on this date - becomes disabled
sudo chage -E 2026-11-30

# can change the expiration date to reactivate
sudo chage -E 2027-11-30
```

## Sudo

The wheel group is a special group whose members are allowed to use `sudo` so that they can gain root privileges. The word comes from "big wheel" meaning important person with power. This group only exist in RHEL-based systems, while the corresponding group in Debian is sudo.

```bash
# -aG adds one supplementary group wheel to bob
sudo usermod -aG wheel bob
```

You can check using the id command 

```bash
id bob
```

Now try to login with bob

```bash
ssh bob@<ip-address>

sudo cat /etc/shadow
```

To remove sudo access, you revoke the group 

```bash
sudo gpasswd -d bob wheel
```

Note that this applies first during the next session, so if bob is logged in now he still has sudo. 

## Delete an account

```bash
# removese entries from passwd/shadow and group that was created with same name as bob, secondary groups still there
sudo userdel bob

# also remove home dir
sudo userdel -r bob
