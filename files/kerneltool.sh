#!/bin/bash -eu

# Utility functions
name="$(basename "$0")"
out() { echo "$name:" "$@" ; }
err() { echo "$name:" "$@" 1>&2 ; }
die() { err "$@" ; exit 1 ; }
logged() { out "$@" ; "$@" ; }
qgrep() { grep "$@" >/dev/null 2>&1 ; }

help() {
	die "usage: 

  $name list
  $name show
  $name latest
  $name purge {kernel}
"
}

latest-kernel() {
	kerneltool list | sort -u | tail -1
}

show-kernel() {
	kernel-config list | grep '\*' | tr -s ' ' | cut -d ' ' -f 3 | sed -e 's@^linux-@@g'
}

list-kernels() {
	kernel-config list | grep '^ ' | tr -s ' ' | cut -d ' ' -f 3 | sed -e 's@^linux-@@g'
}

purge-kernel() {
	local kernel="$1" ; shift
	[ "$kernel" = "$(show-kernel)" ] && die "$kernel: current kernel cannot be purged"

	# Be careful, since we will delete things
	echo "$kernel" | qgrep '^[a-z0-9]' || die "$kernel: no such kernel"

	local last="${kernel##*-}"

	# Get the revision suffix - might be empty
	local rev="-r${last##r}"
	[ "$rev" = "-r$last" ] && rev=''

	# Get the rest without the revision
	local rest="${kernel}"
	[ -n "$rev" ] && rest="${kernel%-*}"

	# Get the name suffix and the plain version
	local suffix="${rest##*-}"
	local version="${rest%-*}"

	# Artifact paths
	local src="/usr/src/linux-$kernel"
	local mod="/lib/modules/$kernel"
	local cfg="/boot/config-$kernel"
	local map="/boot/System.map-$kernel"
	local vml="/boot/vmlinuz-$kernel"
	local irf="/boot/initramfs-$kernel"

	# Check for kernel remnants
	mountpoint -q /boot || mount /boot
	list-kernels | qgrep -P "^\Q$kernel" || 
		[ -d "$src" ] ||
		[ -d "$mod" ] ||
		[ -f "$cfg" ] ||
		[ -f "$map" ] ||
		[ -f "$vml" ] ||
		[ -f "$irf" ] ||
		die "$kernel: no such kernel"

	# Deselect the kernel
	logged emerge --deselect "=sys-kernel/${suffix}-sources-${version}${rev}" || true

	# Remove source code and build artifacts
	logged rm -rf "${src}" || true

	# Remove modules
	logged rm -rf "$mod" || true

	# Remove boot artifacts
	logged rm -f "$cfg" "$cfg".* "$map" "$map".* "$vml" "$vml".* "$irf" "$irf".* || true

	# Unmerge the kernel
	logged emerge --unmerge "=sys-kernel/${suffix}-sources-${version}${rev}" || true
}


cmd="${1:-}" ; shift || true
case "$cmd" in
show) show-kernel ;;
list) list-kernels ;;
purge)
	[ $# -eq 1 ] || help
	purge-kernel "$1"
	;;
*)    help ;;
esac
