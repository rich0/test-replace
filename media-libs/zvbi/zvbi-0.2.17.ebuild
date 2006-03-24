# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/zvbi/zvbi-0.2.17.ebuild,v 1.5 2006/03/24 16:34:06 agriffis Exp $

IUSE="X nls v4l dvb doc"

DESCRIPTION="VBI Decoding Library for Zapping"
SRC_URI="mirror://sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ia64 ~ppc ~sparc x86"

RDEPEND="X? ( || ( x11-libs/libX11 virtual/x11 ) )
	media-libs/libpng
	sys-libs/zlib"

DEPEND="${RDEPEND}
	X? ( || ( (
			x11-libs/libXt
			x11-proto/xproto
		) virtual/x11 ) )
	virtual/os-headers
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen )"

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable v4l) \
		$(use_enable dvb) \
		$(use_with X x) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install () {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	use doc && dohtml -a png,gif,html,css doc/html/*
}
