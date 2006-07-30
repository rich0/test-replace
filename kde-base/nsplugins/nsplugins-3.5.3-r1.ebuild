# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nsplugins/nsplugins-3.5.3-r1.ebuild,v 1.1 2006/07/30 19:07:55 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=3.5.4
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Netscape plugins support for konqueror"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

PATCHES="${FILESDIR}/${P}-applet-redirects.patch"
