# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cxfe/cxfe-0.9.1.ebuild,v 1.4 2006/02/23 21:41:39 arj Exp $

inherit eutils

DESCRIPTION="A command line interface for xine."
HOMEPAGE="http://www.rtwnetwork.com/cxfe/"

SRC_URI="ftp://ftp.rtwnetwork.com/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="lirc"

RDEPEND=">=media-libs/xine-lib-1_rc1
	   || ( ( x11-libs/libX11
	      x11-libs/libXext )
	   virtual/x11 )
	   lirc? ( app-misc/lirc )
	   sys-libs/ncurses"

DEPEND="${RDEPEND}
	   || ( ( x11-libs/libX11
	      x11-libs/libXext )
	   virtual/x11 )"
src_unpack() {
	unpack ${A}
	mv cxfe ${P}
	cd ${P}
	epatch ${FILESDIR}/gcc-2.95-fix.patch
	epatch ${FILESDIR}/max-osd-fix.patch
	epatch ${FILESDIR}/xv-default.patch
}

src_install() {
	dobin cxfe
	dodoc README TODO lircrc-example
}
