# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fluxconf/fluxconf-0.8.5.ebuild,v 1.9 2004/06/24 22:18:33 agriffis Exp $

DESCRIPTION="Configuration editor for fluxbox"
SRC_URI="http://devaux.fabien.free.fr/flux/${P}.tar.gz"
HOMEPAGE="http://devaux.fabien.free.fr/flux/"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc "

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {

	econf || die
	emake || die
}

src_install () {

	einstall || die


	rm ${D}/usr/bin/fluxkeys ${D}/usr/bin/fluxmenu

	dosym /usr/bin/fluxconf /usr/bin/fluxkeys
	dosym /usr/bin/fluxconf /usr/bin/fluxmenu

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
