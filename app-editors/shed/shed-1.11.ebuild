# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/shed/shed-1.11.ebuild,v 1.6 2005/06/05 11:32:21 hansmi Exp $

IUSE=""

DESCRIPTION="Simple Hex EDitor"
HOMEPAGE="http://shed.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="ppc x86"
SLOT="0"

DEPEND=">=sys-libs/ncurses-5.3"

src_compile() {

	econf || die
	emake AM_CFLAGS="${CFLAGS}" || die

}

src_install() {

	make DESTDIR=${D} install || die
	dodoc [A-Z][A-Z]* ChangeLog

}
