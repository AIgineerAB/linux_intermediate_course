# passwd and shadow 

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
   2. blank -> no password
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