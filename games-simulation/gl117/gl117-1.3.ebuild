# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/gl117/gl117-1.3.ebuild,v 1.4 2004/09/11 09:47:01 blubb Exp $

inherit games eutils

MY_P="gl-117-${PV}-src"
DESCRIPTION="An action flight simulator"
HOMEPAGE="http://home.t-online.de/home/primetime./gl-117/"
SRC_URI="mirror://sourceforge/gl-117/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="virtual/x11
	media-libs/libsdl
	media-libs/sdl-mixer
	virtual/opengl
	virtual/glu
	virtual/glut"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc-3.4-gentoo.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog FAQ NEWS README
	prepgamesdirs
}
