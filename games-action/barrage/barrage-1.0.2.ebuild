# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/barrage/barrage-1.0.2.ebuild,v 1.5 2007/05/21 17:24:48 tupone Exp $

inherit games

DESCRIPTION="A violent point-and-click shooting game"
HOMEPAGE="http://lgames.sourceforge.net"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-mixer-1.2.4"

src_compile() {
	egamesconf --datadir=${GAMES_DATADIR_BASE} || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog README
	prepgamesdirs
}
