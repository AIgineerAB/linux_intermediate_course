# Daemons

<a href="" target="_blank">
  <img src="https://github.com/kokchun/assets/blob/main/FOLDER_NAME/.png?raw=true" alt="DESCRIPTION" width="600">
</a>

## What are daemons?

Daemons are background programs that run continuously without direct without user interactions. They handle essential system tasks and services.

Example

| daemon      | full name            | does?                                             |
| ----------- | -------------------- | ------------------------------------------------- |
| sshd        | secure shell daemon  | listen for remote login and file transfer         |
| crond       | chronological daemon | run scheduled tasks                               |
| systemd     | system daemon        | PID 1, manages, starts and monitor other daemons  |
| httpd/nginx | http daemon          | listen for web requests and serves websites pages |

You can check some available daemons in your system and its description with this command

```bash

# opens up in less
systemctl list-units --type=service --all

# view running services
systemctl list-units --type=service --state=running

# see all daemon unit files even disabled ones
systemctl list-unit-files --type=service

# combine with awk and column to get nicely printing
# blank out $1,...,$4 so that we can print everything the rest of description with $0
systemctl list-units --type=service --state=running --no-pager | awk '{u=$1; $1=$2=$3=$4=""; print u "?" $0}' | column -t -s?
```

Here are some of the services from the above command

```
UNIT                            DESCRIPTION
accounts-daemon.service         Accounts Service
alsa-state.service              Manage Sound Card State (restore and store)
atd.service                     Deferred execution scheduler
auditd.service                  Security Audit Logging Service
avahi-daemon.service            Avahi mDNS/DNS-SD Stack
chronyd.service                 NTP client/server
colord.service                  Manage, Install and Generate Color Profiles
crond.service                   Command Scheduler
cups.service                    CUPS Scheduler
dbus-broker.service             D-Bus System Message Bus
firewalld.service               firewalld - dynamic firewall daemon
gdm.service                     GNOME Display Manager
```

> [!NOTE]
> Fun fact, the word daemon comes from greek mythology and are not inherently good or evil and the physicist Maxwell imagined tiny, unseen beings (demons) that helped sort molecules into two chambers. This later on inspired the unix word daemon to represent background services.

## Master daemon

Systemd is the master daemon, i.e. the daemon that starts up all other services including daemons in your system. Note that the systemd refers to other services as units. We control this daemon using systemctl command.

Here are commands to stop, check status and start other units.

```bash
systemctl stop colord

systemctl status colord

systemctl start colord
```

To make a daemon startup automatically at boot make it enabled, many are enabled by default. You can disable it and enable it. Here is an example with rsyslog

```bash
systemctl disable rsyslog

systemctl enable rsyslog
```

You can check the status that it is still running even though you disable it, but it says that it is disabled.

Enabling in systemd creates a symlink to a certain directory for example `/usr/lib/systemd/system/rsyslog.service` for rsyslog. This is how systemd knows what services to startup at boot.

You can also check if it is enabled or active with

```bash
systemctl is-active rsyslog
systemctl is-enabled rsyslog
```

### Many unit types

Systemd manages many different unit types and .service is the one that are daemons. Here is a way to find out a frequency count for various units

```bash
# split . with awk and picks the last element, then pipe it to sort so that we can do uniq -c  for freq count
systemctl list-units --no-legend --no-pager --plain | awk '{n=split($1,a,"."); print a[n]}' | sort | uniq -c
```

Here is an example output

```bash
     1 automount
     13 device
     12 mount
      3 path
      3 scope
     61 service
      9 slice
     23 socket
      1 swap
     23 target
      7 timer
```

## Other videos 📹

## Read more 👓
