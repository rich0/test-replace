# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/doc++/doc++-3.4.10.ebuild,v 1.2 2003/09/21 09:57:19 aliz Exp $

DESCRIPTION="Documentation system for C, C++, IDL and Java"
SRC_URI="mirror://sourceforge/docpp/${P}.tar.gz"
HOMEPAGE="http://docpp.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	./configure -prefix /usr || die
	make all || die
}

src_install() {
	einstall

	dodoc ABOUT-NLS COPYING CREDITS INSTALL NEWS PLATFORMS REPORTING-BUGS
}

