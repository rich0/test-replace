# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-stunnel/selinux-stunnel-20050626.ebuild,v 1.2 2005/06/26 17:49:38 kaiowas Exp $

inherit selinux-policy

TEFILES="stunnel.te"
FCFILES="stunnel.fc"
IUSE=""
RDEPEND=">=sec-policy/selinux-base-policy-20050618"

DESCRIPTION="SELinux policy for stunnel"

KEYWORDS="x86 ppc sparc amd64"

