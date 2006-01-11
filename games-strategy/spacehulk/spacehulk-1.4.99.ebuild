# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/spacehulk/spacehulk-1.4.99.ebuild,v 1.7 2006/01/11 21:34:29 mr_bones_ Exp $

inherit games kde-functions

DESCRIPTION="A boardgame in the world of Warhammer 40k"
HOMEPAGE="http://r.vinot.free.fr/spacehulk/"
SRC_URI="http://freesoftware.fsf.org/download/spacehulk/main.pkg/${PV}/${P}.tar.gz
	http://freesoftware.fsf.org/download/spacehulk/themespack.pkg/1.0/spacehulk-themespack-1.0.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE="xinerama"

DEPEND="=x11-libs/qt-3*
	sys-libs/zlib
	media-libs/libpng
	media-libs/jpeg
	media-libs/nas"

src_compile() {
	set-qtdir 3
	egamesconf \
		$(use_with xinerama) \
		|| die
	emake || die "emake failed"
}

src_install() {
	egamesinstall || die
	cp -R ../themes/* "${D}${GAMES_DATADIR}/${PN}/themes" || die "cp failed"
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
