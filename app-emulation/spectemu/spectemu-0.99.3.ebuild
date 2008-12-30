# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spectemu/spectemu-0.99.3.ebuild,v 1.12 2008/12/30 19:17:56 angelos Exp $

### Several versions of specemu exist,  xspect & vgaspect, utilising X11
### and/or svgalib. libreadline provides optional runtime features.
### The ./configure script automagically figures out which binaries to build
### so the run/compiletime dependancies here are use dependant

inherit eutils

DESCRIPTION="48k ZX Spectrum Emulator"
HOMEPAGE="http://kempelen.iit.bme.hu/~mszeredi/spectemu/spectemu.html"
SRC_URI="http://www.inf.bme.hu/~mszeredi/spectemu/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X readline svga"

DEPEND="X? ( >=x11-proto/xf86vidmodeproto-2.2.2
		>=x11-proto/xextproto-7.0.2
		>=x11-proto/xproto-7.0.4
		>=x11-libs/libX11-1.0.0
		>=x11-libs/libXext-1.0.0
		>=x11-libs/libXxf86vm-1.0.0 )
	readline? ( sys-libs/readline )"
RDEPEND="svga? ( media-libs/svgalib )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-qa.patch
}

src_compile() {
	econf \
		$(use_with readline) \
		$(use_with X x)
	emake CC="$(tc-getCC)" \
		CPP="$(tc-getCPP)" \
		|| die "emake failed"
}

src_install() {
	emake install_root="${D}" install || die "emake install failed"
}
