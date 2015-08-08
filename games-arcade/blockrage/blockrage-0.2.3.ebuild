# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4
inherit eutils games

DESCRIPTION="Falling-blocks arcade game with a 2-player hotseat mode"
HOMEPAGE="http://blockrage.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl"
RDEPEND="${DEPEND}"

# Removing error due to wrong detection of cross-compile mode
PATCHES=( "${FILESDIR}/${P}"-config.patch )
DOCS=( ChangeLog KNOWN_BUGS README TODO )

src_install() {
	default
	prepgamesdirs
}
