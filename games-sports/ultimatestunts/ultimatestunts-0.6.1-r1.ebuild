# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/ultimatestunts/ultimatestunts-0.6.1-r1.ebuild,v 1.2 2006/12/06 20:23:34 wolf31o2 Exp $

inherit eutils versionator games

MY_PV=$(replace_all_version_separators '')1
MY_P=${PN}-srcdata-${MY_PV}

DESCRIPTION="Remake of the famous Stunts game"
HOMEPAGE="http://www.ultimatestunts.nl"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/openal
	media-libs/freealut
	virtual/opengl
	virtual/glu
	|| (
		(
			x11-libs/libSM
			x11-libs/libICE
			x11-libs/libX11
			x11-libs/libXi
			x11-libs/libXext
			x11-libs/libXmu
			x11-libs/libXt )
		virtual/x11 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:/etc/ultimatestunts.conf:${GAMES_SYSCONFDIR}/ultimatestunts.conf:" \
		shared/usmisc.cpp \
		|| die "sed failed"

	sed -i \
		-e '302,306s#${usdatadir}#$(DESTDIR)${usdatadir}#' \
		data/Makefile.in \
		|| die "sed failed"

	#fix up install paths (bug #130513)
	sed -i \
		-e "s:\${prefix}/share/ultimatestunts/:${GAMES_DATADIR}/ultimatestunts/:" \
		configure \
		|| die "sed failed"

	epatch \
		"${FILESDIR}/${P}"-64bits.patch \
		"${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}/${P}"-freealut.patch
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	make_desktop_entry ustunts "Ultimate Stunts"
	dodoc AUTHORS README TODO
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "Please update or remove ~/.ultimatestunts/ultimatestunts.conf"
	einfo "if you have it to update the path for the data files."
	echo
}
