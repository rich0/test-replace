# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/whitebox/whitebox-0.5.ebuild,v 1.5 2004/06/24 22:36:17 agriffis Exp $

IUSE=""

MY_P="whiteBOX-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Configuration editor for blackbox type window managers. Not all features work with all window managers."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	http://mkeadle.org/distfiles/${PN}-pixmaps.tbz2"
HOMEPAGE="http://whitebox.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/gdk-pixbuf-0.22"

RDEPEND="virtual/blackbox"

src_compile () {

	econf || die
	emake || die
}

src_install () {

	einstall || die
	insinto /usr/share/whiteBOX/pixmaps
	doins ${WORKDIR}/pixmaps/*.xpm
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
