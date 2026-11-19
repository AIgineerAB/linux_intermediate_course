# Logs in linux

<a href="" target="_blank">
  <img src="https://github.com/kokchun/assets/blob/main/FOLDER_NAME/.png?raw=true" alt="DESCRIPTION" width="600">
</a>

## What are logs?

Timeline records of system, kernel, application and user events saved into text or binary files (sequence of raw bytes for machines to read). Logs are tools for troubleshooting, security monitoring, performance tracking, audit trails and preventive maintenance.

## /var/log

This is where system logs or system journal are stored. It stores errors, warning and other system activities.

The path /var/log stands for

- var -> variable (files changing over time)
- log -> record system activities

## How to navigate logs

This is a list of all the log files that exists in a VM of mine.

```bash
anaconda           btmp             dnf.log              maillog            private            spooler-20261018     vboxadd-setup.log.3
audit              btmp-20261101    dnf.rpm.log          maillog-20261018   qemu-ga            spooler-20261031     vboxadd-setup.log.4
boot.log           chrony           firewalld            maillog-20261031   samba              spooler-20261101     vboxadd-uninstall.log
boot.log-20261018  cron             gdm                  maillog-20261101   secure             spooler-20261112     wtmp
boot.log-20261023  cron-20261018    hawkey.log           maillog-20261112   secure-20261018    sssd
boot.log-20261024  cron-20261031    hawkey.log-20261012  messages           secure-20261031    tuned
boot.log-20261031  cron-20261101    hawkey.log-20261018  messages-20261018  secure-20261101    vboxadd-install.log
boot.log-20261101  cron-20261112    hawkey.log-20261031  messages-20261031  secure-20261112    vboxadd-setup.log
boot.log-20261102  cups             hawkey.log-20261112  messages-20261101  speech-dispatcher  vboxadd-setup.log.1
boot.log-20261112  dnf.librepo.log  lastlog              messages-20261112  spooler            vboxadd-setup.log.2
```

Here are some important log files for RHEL based systems such as Oracle Linux:

- /var/log/boot.log - logs related system startup
- /var/log/secure - security and authentication messages
- /var/log/cron - for periodically executed tasks
- /var/log/messages - other syslog messages

## Examples of searching through logs

Note that many examples require root access to view the logs, so we need to use sudo.

`/var/log/boot.log`

```bash
# print out all messages
sudo cat /var/log/boot.log

# find only the failed ones
sudo grep -i failed /var/log/boot.log

# only the bottom 6 rows
sudo tail -n 6 /var/log/boot.log
```

`/var/log/dnf.log`

```bash
# filter out all warnings
grep -i warning /var/log/dnf.log

# try out to make a failed install
sudo dnf install fakefailpackage

# filter out all errors and get newest entries
grep -i error /var/log/dnf.log | tail
```

`/var/log/messages`

```bash
# finds ssh related logs
sudo grep -i "sshd" messages

# find errors
sudo grep -iE "error|fail|denied|critical" /var/log/messages

# follow live
sudo tail -f /var/log/messages
```

## logrotation

If you do

```bash
ls | grep messages
```

you would see something like

```bash
messages
messages-20261031
messages-20261101
messages-20261112
messages-20261119
```

This is a periodical logrotation happening, which stores the logs from the previous rotation up to the timestamp of the new logrotation.

The default is usually 4 logrotations in RHEL, keeping 4 weeks of data. In the next logrotation, the oldest one is deleted.

## journalctl to view journald logs

By default (in RHEL systems) the journal isn't persistent and is stored under `/run/log/journal` which is wiped out after shutting down. The data is forwarded to rsyslog which stores it in `/var/run/messages` (persistent on disk, rotated by logrotate).

```bash
# shows all collected journal entries
journalctl

# newest first
journalctl -r

# last 50 lines
journalctl -n 50

# no pager for piping/grep
journalctl --no-pager | grep -i error
```

**filter by service/unit**

```bash
# sshd service
journalctl -u sshd

# sshd and chronyd
journalctl -u sshd -u chronyd

# user service
journalctl --user -b -u service_name

# gnome display manager since today
journalctl -u gdm --since today
```

**filter by time**

```bash
journalctl --since "10 minute ago"
journalctl --since "1 hour ago"
journalctl --since yesterday
journalctl --since today
```

**filter by **

```bash
```

## Read more 👓

- [what is /var/log: understanding linux system logs - last9 ](https://last9.io/blog/what-is-var-log/)
- [Troubleshooting problems by using log files - Red Hat documentation](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/configuring_basic_system_settings/assembly_troubleshooting-problems-using-log-files_configuring-basic-system-settings)
