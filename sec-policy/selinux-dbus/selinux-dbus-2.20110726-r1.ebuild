# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dbus/selinux-dbus-2.20110726-r1.ebuild,v 1.1 2011/10/23 11:00:19 swift Exp $
EAPI="4"

IUSE=""
MODS="dbus"
BASEPOL="2.20110726-r5"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for dbus"

KEYWORDS="~amd64 ~x86"
