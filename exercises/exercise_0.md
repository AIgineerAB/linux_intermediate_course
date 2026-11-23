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

DESCRIPTION

&nbsp; a)

&nbsp; b)

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
