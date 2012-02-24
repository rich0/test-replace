# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/oclock/oclock-1.0.3.ebuild,v 1.1 2012/02/24 15:35:22 chithanh Exp $

EAPI=4

inherit xorg-2

DESCRIPTION="round X clock"

KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXext"
DEPEND="${RDEPEND}"
