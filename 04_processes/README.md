# Proceses

<a href="" target="_blank">
  <img src="https://github.com/kokchun/assets/blob/main/linux/processes.png?raw=true" alt="processes" width="600">
</a>

## Process and process id (PID)

A program is a passive file that can be executed by Linux kernel. When the program is executed an instance of that program is created (process).

When you run a command, linux is dynamically creating a process and gives it a PID, which is used for tracking and managing processes. 

## Foreground process

Processes starts in foreground by default taking keyboard input, and blocks the terminal and sends output to screen.

During time of execution you can't run anything until it's finished.

## Background process

Adding an ampersand `&` after the command will send it to the background. Sending it to the background means you can do other things in the terminal. 

Example 
```bash
sleep 5 

# outputs, where [1] is the job number and 73541 is the PID
[1] 73541
```

## Read more

- [Processes in Linux - geeksforgeeks](https://www.geeksforgeeks.org/linux-unix/processes-in-linuxunix/)
- [Get Process ID of Linux Foreground and Background Processes - geeksforgeeks](https://www.geeksforgeeks.org/linux-unix/get-process-id-of-linux-foreground-and-background-processes/)
