# passwd and shadow 

<a href="" target="_blank">
  <img src="https://github.com/kokchun/assets/blob/main/FOLDER_NAME/.png?raw=true" alt="DESCRIPTION" width="600">
</a>

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


## User management and passwd