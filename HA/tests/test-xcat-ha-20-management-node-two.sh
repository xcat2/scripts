#!/bin/bash
#
# Run this script on second xCAT management node to be.
#
# This script will run xcatha.py to setup the second xCAT management node
# and then, run a compute node deployment
#
# Check test-xcat-ha.conf for configurations
#

set -x

PATH="/opt/xcat/bin:/opt/xcat/sbin:/usr/sbin:/usr/bin:/root/bin"
export PATH

BASE_DIR="${0%/*}"

source "${BASE_DIR}/test-xcat-ha.conf"

xcatha.py -s -p "${SHARED_DIRECTORY}" -i "${XCAT_MN_INTERFACE}" \
	-v "${VIRTUAL_IP_ADDR}" -m "${VIRTUAL_NETMASK}" \
	-n "${VIRTUAL_HOSTNAME}" -t sqlite
[ "$?" != "0" ] && exit 1

xcatha.py -a -p "${SHARED_DIRECTORY}" -i "${XCAT_MN_INTERFACE}" \
	-v "${VIRTUAL_IP_ADDR}" -m "${VIRTUAL_NETMASK}"
[ "$?" != "0" ] && exit 1

rinstall "${COMPUTE_NODE}" osimage=rhels7.5-ppc64le-install-compute 
[ "$?" != "0" ] && exit 1

NETBOOT_TIMEOUT=600
declare -i WAIT=0

while sleep 10
do
	(( WAIT += 10 ))
	nodestat "${COMPUTE_NODE}" | grep ': sshd$'
	[ "$?" -eq "0" ] && break
	[ "${WAIT}" -le "${NETBOOT_TIMEOUT}" ]
	[ "$?" -ne "0" ] && echo "Netboot failed." >&2 && exit 1
done

# For workaround the GitHub issue #3549
sleep 5

xdsh "${COMPUTE_NODE}" date
[ "$?" -ne "0" ] && echo "Failed connect to compute node via SSH." >&2 && exit 1

xcatha.py -d -i "${XCAT_MN_INTERFACE}" -v "${VIRTUAL_IP_ADDR}"
[ "$?" != "0" ] && exit 1
