# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils games

DESCRIPTION="Freedroid - a Paradroid clone"
HOMEPAGE="http://freedroid.sourceforge.net/"
SRC_URI="mirror://sourceforge/freedroid/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl[joystick,sound,video]
	virtual/jpeg
	sys-libs/zlib
	media-libs/libpng:0
	media-libs/sdl-image[jpeg,png]
	media-libs/sdl-mixer[mod,vorbis]
	media-libs/libvorbis"

src_install() {
	default
	find "${D}" -name "Makefile*" -exec rm -f '{}' +
	rm -rf "${D}${GAMES_DATADIR}/${PN}/"{freedroid.6,mac-osx} || die
	newicon graphics/paraicon.bmp ${PN}.bmp
	make_desktop_entry freedroid Freedroid /usr/share/pixmaps/${PN}.bmp
	prepgamesdirs
}
