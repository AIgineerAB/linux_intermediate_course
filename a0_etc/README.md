# Appendix 0 - /etc directory  

<a href="" target="_blank">
  <img src="https://github.com/kokchun/assets/blob/main/FOLDER_NAME/.png?raw=true" alt="DESCRIPTION" width="600">
</a>


In this lecture we'll cover many other important files inside of /etc directory that haven't been covered elsewhere in this course.

## /etc/fstab 

fstab stands for file system table and tells Linux what filesystems to mount during boot and where. 

This is the structure of each line:

```bash
<device>  <mount point>  <fs type>  <options>  <dump>  <fsck order>
```

- device -> what to mount (usually UUID)
- mount point -> where to attach in directory tree
- fs type -> xfs, ext4, swap, vfat ...
- options -> mount behaviour
- dump -> legacy backup flag
- fsck order -> (filesystem check) 1 = root, 2 = others, 0 = skip


## /etc/

## /etc/sudoers

...