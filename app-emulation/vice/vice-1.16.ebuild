# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vice/vice-1.16.ebuild,v 1.1 2005/02/12 05:44:12 mr_bones_ Exp $

inherit games

DESCRIPTION="The Versatile Commodore 8-bit Emulator"
HOMEPAGE="http://www.viceteam.org/"
SRC_URI="ftp://ftp.funet.fi/pub/cbm/crossplatform/emulators/VICE/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="arts gnome nls sdl X Xaw3d"

# FIXME: esound is required until configure.in is patched.
DEPEND="virtual/libc
	media-sound/esound
	media-libs/libpng
	sys-libs/zlib
	arts? ( kde-base/arts )
	ffmpeg? ( media-video/ffmpeg )
	gnome? ( gnome-base/libgnomeui )
	readline? ( sys-libs/readline )
	sdl? ( media-libs/libsdl )
	X? ( virtual/x11 )
	Xaw3d? ( x11-libs/Xaw3d )"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--enable-fullscreen \
		--enable-textfield \
		--enable-ethernet \
		--enable-realdevice \
		--with-resid \
		--without-midas \
		$(use_enable ffmpeg) \
		$(use_enable gnome gnomeui) \
		$(use_enable nls) \
		$(use_with X x) \
		$(use_with Xaw3d xaw3d) \
		$(use_with arts) \
		$(use_with readline) \
		$(use_with sdl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	local docdir="${D}${GAMES_LIBDIR}/${PN}/doc"

	make DESTDIR="${D}" install || die "make install failed"
	dohtml "${docdir}/"* || die "dohtml failed"
	dodoc \
		AUTHORS ChangeLog FEEDBACK README \
		"${docdir}/"{BUGS,NEWS,PETdoc.txt,TODO} \
		"${docdir}/"{cbm_basic_tokens.txt,drive_info.txt,mon.txt,serial.txt}
	rm -rf "${docdir}"
	prepgamesdirs
}
