# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ed2k-gtk-gui/ed2k-gtk-gui-0.6.2.ebuild,v 1.1 2004/04/21 20:51:19 squinky86 Exp $

inherit libtool

DESCRIPTION="GTK+ Client for overnet"
HOMEPAGE="http://ed2k-gtk-gui.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
	>=net-libs/gnet-1.1
	>=net-p2p/overnet-0.51*"

src_compile() {
	econf || die "configure failed"
	sed -i -e "s:-DG_DISABLE_DEPRECATED -DGDK_DISABLE_DEPRECATED -DGTK_DISABLE_DEPRECATED::g" ed2k_gui/Makefile
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
}

pkg_postinst() {
	einfo
	einfo "In order to run ${P}, please"
	einfo "copy /usr/bin/overnet to the home directory"
	einfo "of the user who will be using this program:"
	einfo " cp /usr/bin/overnet ~/"
	einfo
}
