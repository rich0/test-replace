# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmMoonClock/wmMoonClock-1.27.ebuild,v 1.8 2004/03/26 23:10:07 aliz Exp $

IUSE=""
DESCRIPTION="dockapp that shows lunar ephemeris to a high accuracy."
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${P}.tar.gz"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"

DEPEND="virtual/glibc
	virtual/x11"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~mips"

src_unpack() {
	unpack ${A} ; cd ${S}/Src
	sed -i -e "s:-O2:${CFLAGS}:" Makefile
}

src_compile() {
	emake -C Src || die "parallel make failed"
}

src_install () {
	dobin Src/wmMoonClock
	doman Src/wmMoonClock.1
	dodoc BUGS
}

