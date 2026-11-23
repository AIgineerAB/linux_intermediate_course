# Exercise 0 - Tools for data processing

In this exercise, you get to familiarize yourself with regular expressions and awk so that you can process various files in Linux. We'll focus on `/etc` directory which stores system-wide configurations files. These files control the behavior of operating system, services and installed softwares.

Purpose of this exercise is both to learn the neccessary tools to search and process text files and also to learn about various files in Linux.

## 0. Search /etc/vimrc with grep -E

Let's start with checking out /etc/vimrc to see the system-wide configurations for vim. Note that this differs from the user specific ones in your home directory i.e. ~/.vimrc.

&nbsp; a) Search for all lines starting with set

&nbsp; b) Search for all lines starting with set and starting with leading spaces and then set (note that vim ignores leading whitespaces).

<!-- grep -En '^(set| +set)' vimrc -->
<!-- grep -Enc '^ *set' vimrc -->

&nbsp; c) Starting with a quote " is a comment in vimrc. Search for all comments starting with a quote

<!-- grep -En '^ *"' vimrc  -->

## 1. Parse /etc/shadow

Password hashes are stored in /etc/shadow and you neet root access to be able to read this file.

&nbsp; a) Start with creating a new user and a password for that user with

```bash
sudo useradd -m Bob
sudo passwd Bob

# create another one that has no password
sudo useradd -m Camille
```

&nbsp; b) Now get only those fields with password. Also add headers also so example could be:

```
USER     HASH
Bob      $y$j9T$7Liode2IMq5agwZn8LtflOfi$JctLEwKDmux6NtgcifAEJThXXZ.wQn6OgKkvdZ8WomB
David    $y$j9T$kw901m0uAeUfxTdaeyDHU0$wdPLRsYT4zbSXUPUtdIJZl209rUpm4I0zKCDW8D8pb.
bib      $y$j9T$pbfrLv19BApMmIwSawtCM1$j1ZCmHhLsmSkB0FXXMefQhk/f1v1OO1zfxJlEuJXmt1
```

<!--  sudo awk -F: 'BEGIN {print "USER,HASH"} $2~/^\$/ {print $1 "," $2}' shadow | column -t -s, -->

&nbsp; c)

&nbsp; d)

&nbsp; e)

## 2. Theory questions

DESCRIPTION

&nbsp; a)

&nbsp; b)

&nbsp; c)

## Glossary

Fill in this table either by copying this into your own markdown file or copy it into a spreadsheet if you feel that is easier to work with.

| terminology | explanation |
| ----------- | ----------- |
|             |             |
|             |             |
|             |             |
|             |             |
|             |             |
|             |             |
|             |             |
|             |             |
|             |             |
|             |             |
