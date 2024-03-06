# ansible-role-kernel

## Overview

Performs Linux kernel related tasks on different operating systems.

### Debian

- Installs Linux kernel headers, so that out-of-tree modules can be built

### Armbian

- Installs Linux kernel headers and kernel source, so that out-of-tree modules can be built

### Gentoo

- Installs a `kerneltool` script for managing Linux kernels on Gentoo
- Selects and symlinks the latest `sys-kernel/gentoo-sources` Linux kernel.
- Configures, buidls and installs the Linux kernel
- Builds and installs the initramfs
- Generates grub configuration

## kerneltool

This tool is installed on gentoo to aid in Linux kernel related operations.

```
kerneltool: usage: 

  kerneltool list
  kerneltool show
  kerneltool latest
  kerneltool link {kernel}
  kerneltool purge {kernel}
```
