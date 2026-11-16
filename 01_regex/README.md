# Regex to find matchees

<a href="" target="_blank">
  <img src="https://github.com/kokchun/assets/blob/main/FOLDER_NAME/.png?raw=true" alt="DESCRIPTION" width="600">
</a>

## Use cases

- data validation - check input matches specific format
- search and replace - find pattern and swap out
- text parsing - extract specific info from text

## /etc/passwd

We'll use /etc/passwd as an example for this lecture. This is an important system file to store info about user accounts. We'll dive deeper into /etc/passwd in a separate lecture.

Structure looks like this

```bash
$ head -n 5 /etc/passwd
root:x:0:0:Super User:/root:/bin/bash
bin:x:1:1:bin:/bin:/usr/sbin/nologin
daemon:x:2:2:daemon:/sbin:/usr/sbin/nologin
adm:x:3:4:adm:/var/adm:/usr/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/usr/sbin/nologin
```

## Regex with grep -E

So regex or regular expression exists in many programming languages and many tools. A good point to start is grep with the E flag, which is the extended syntax for grep (some extra characters like + ? | () {} without backslashes).

Always use single quotes '' for bash to ignore interpreting special characters.

```bash
# matches literal characters 'root'
grep -E 'root' /etc/passwd

# ^ anchor -> starting with root
grep -E '^root' /etc/passwd

# $ anchor -> end with bash
grep -E 'bash$' /etc/passwd

# characater class [], + is a quantifier giving one or more
grep -E '^[a-z]+' /etc/passwd

# matches one or several starting with k or o
grep -E '^[ko]+' /etc/passwd

# {n}: 4-digit UID
grep -E '[0-9]{4}' /etc/passwd

# accounts that can't login
# match ending with nologin or false - grouping and alternation (|)
grep -E '(nologin|false)$' /etc/passwd

# flip it with -v in grep -> all users that can login 
grep -Ev '(nologin|false)$' /etc/passwd



```

## Other videos 📹

## Read more 👓
