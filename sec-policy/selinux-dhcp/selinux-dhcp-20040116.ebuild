# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dhcp/selinux-dhcp-20040116.ebuild,v 1.1 2004/01/17 03:47:24 pebenito Exp $

TEFILES="dhcpd.te"
FCFILES="dhcpd.fc"

inherit selinux-policy

DESCRIPTION="SELinux policy for dhcp server"

KEYWORDS="x86 ppc sparc"

