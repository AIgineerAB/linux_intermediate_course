# Regex to find matchees

<a href="https://youtu.be/mZyTzwmypKY" target="_blank">
  <img src="https://github.com/kokchun/assets/blob/main/linux/regex.png?raw=true" alt="DESCRIPTION" width="600">
</a>

> [!NOTE]
> if you don't have color coding on your shell for grep, then add this line to .bashrc 
>
> `grep='grep --color=auto'`



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

# add c flag to grep to count it
grep -Ec '(nologin|false)$' /etc/passwd

# flip it with -v in grep -> all users that can login
grep -Ev '(nologin|false)$' /etc/passwd


# finds all users with /home. [^:]* means match any character not colon and * matches 0 or more of that character class
grep -E ':/home[^:]*' /etc/passwd
```

## Regex table for reference

| Category      | Pattern                       | Meaning                            | Example (`grep -E` on `/etc/passwd`) |
| ------------- | ----------------------------- | ---------------------------------- | ------------------------------------ |
| Anchor        | `^`                           | start of line                      | `'^root'`                            |
| Anchor        | `$`                           | end of line                        | `'bash$'`                            |
| Anchor        | `\b`                          | word boundary (GNU grep)           | `'\bsync\b'`                         |
| Character     | `.`                           | any single character               | `'r..t'`                             |
| Character     | `[abc]`                       | one of a, b, c                     | `'^[rk]'`                            |
| Character     | `[a-z]`                       | one character in range             | `'^[a-z]+:'`                         |
| Character     | `[^abc]`                      | one character NOT a, b, c          | `'^[^:]+'`                           |
| Character     | `\.`                          | literal dot (escape special chars) | `'\.'`                               |
| Quantifier    | `*`                           | 0 or more                          | `'^[^:]*:'`                          |
| Quantifier    | `+`                           | 1 or more                          | `'^[^:]+:'`                          |
| Quantifier    | `?`                           | 0 or 1                             | `'colou?r'`                          |
| Quantifier    | `{n}`                         | exactly n                          | `':[0-9]{4}:'`                       |
| Quantifier    | `{n,}`                        | n or more                          | `':[0-9]{4,}:'`                      |
| Quantifier    | `{n,m}`                       | between n and m                    | `':[0-9]{1,3}:'`                     |
| Group         | `(ab)+`                       | group, then repeat the group       | `'(:[0-9]+){2}'`                     |
| Alternation   | `a\|b`                        | a or b (written `a\| b`in`-E`)     | `'^(root\|kokchun):'`                |
| Backreference | `\1`                          | repeat of first group              | `'^([a-z]+):.*:\1:'`                 |
| POSIX class   | `[[:digit:]]`                 | digit                              | `':[[:digit:]]+:'`                   |
| POSIX class   | `[[:alpha:]]`                 | letter                             | `'^[[:alpha:]]+'`                    |
| POSIX class   | `[[:alnum:]]`                 | letter or digit                    | `'^[[:alnum:]]+'`                    |
| POSIX class   | `[[:space:]]`                 | whitespace                         | `'[[:space:]]'`                      |
| POSIX class   | `[[:upper:]]` / `[[:lower:]]` | uppercase / lowercase              | `'[[:upper:]]'`                      |

## Other videos 📹

## Read more 👓
