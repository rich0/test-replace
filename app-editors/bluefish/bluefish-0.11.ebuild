# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/bluefish/bluefish-0.11.ebuild,v 1.3 2003/11/02 11:27:39 hanno Exp $

IUSE="nls spell"

DESCRIPTION="A GTK HTML editor for the experienced web designer or programmer."
SRC_URI="http://pkedu.fbt.eitn.wau.nl/~olivier/downloads/${P}.tar.bz2"
HOMEPAGE="http://bluefish.openoffice.nl/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
SLOT="0"

RDEPEND=">=x11-libs/gtk+-2
	dev-libs/libpcre
	spell? ( app-text/aspell )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_compile() {
	# Fix for icon location (bug #31770)
	sed -i -e 's:ICONDIR/::g' data/bluefish.desktop.in

	local myconf
	myconf=""
	# --enable-auto-optimization  let bluefish determine optimization
	# --disable-splash-screen     disables the splash screen

	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/pixmaps
	dodir /usr/share/applications
	dodir /usr/share/gnome/apps

	einstall \
		datadir=${D}/usr/share \
		pkgdatadir=${D}/usr/share/bluefish \
		pixmapsdir=${D}/usr/share/pixmaps \
		iconpath=${D}/usr/share/pixmaps \
		gnome2menupath=${D}/usr/share/applications \
		gnome1menupath=${D}/usr/share/gnome/apps \
		|| die "make install failed"
}
