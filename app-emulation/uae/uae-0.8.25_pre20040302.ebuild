# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/uae/uae-0.8.25_pre20040302.ebuild,v 1.2 2004/03/04 21:04:12 dholm Exp $

inherit flag-o-matic

MY_PV="0.8.25-20040302"
S="${WORKDIR}/${PN}-${MY_PV}"
DESCRIPTION="The Umiquious Amiga Emulator"
HOMEPAGE="http://www.rcdrummond.net/uae/"
SRC_URI="http://www.rcdrummond.net/uae/uae-${MY_PV}/uae-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="X gtk sdl"

DEPEND="X? ( virtual/x11 gtk? x11-libs/gtk+ ) :
	( ncurses? sys-libs/ncurses svga? media-libs/svgalib )
	sdl? media-libs/libsdl
	app-cdr/cdrtools
	games-emulation/caps"

src_compile() {
	ewarn "Compiling the CPU-core requires a substantial amount of RAM."
	ewarn "Make sure that you have at least 512MB of RAM+SWAP available."

	replace-flags "-O3" "-O2"
	use sdl && myconf="--with-sdl-sound --with-sdl-gfx"

	econf ${myconf} \
		--enable-threads \
		--enable-scsi-device \
		--with-libscg-includedir=/usr/include/scsilib \
		|| die "./configure failed"

	emake -j1 || die "emake failed"
}

src_install() {
	cp docs/unix/README docs/README.unix
	dodoc docs/COMPATIBILITY docs/CREDITS docs/FAQ docs/NEWS \
		docs/README docs/README.PROGRAMMERS docs/README.unix \
		docs/translated/*

	emake install DESTDIR=${D}

	insinto /usr/share/uae/amiga-tools
	doins amiga/{*hack,trans*,uae*,*.library}
}
