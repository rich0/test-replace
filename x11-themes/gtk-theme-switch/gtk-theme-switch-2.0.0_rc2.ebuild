# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-theme-switch/gtk-theme-switch-2.0.0_rc2.ebuild,v 1.11 2004/03/25 23:48:27 foser Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Application for easy change of GTK-Themes"
SRC_URI="http://www.muhri.net/${MY_P}.tar.gz"
HOMEPAGE="http://www.muhri.net/nav.php3?node=gts"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-2*"
SLOT="2"
KEYWORDS="x86 ppc sparc alpha"

src_unpack() {

	unpack ${A}
	cd ${S}
	# Fix build with gtk+-2.4 (#45105)
	epatch ${FILESDIR}/${P}-gtk+-2.4_fix.patch

}

src_compile() {
	make || die
}

src_install () {

	dobin switch2
	mv switch.1 switch2.1
	doman switch2.1
}
