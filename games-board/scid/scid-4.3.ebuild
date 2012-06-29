# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/scid/scid-4.3.ebuild,v 1.4 2012/06/29 12:43:32 ranger Exp $

EAPI=2
PYTHON_DEPEND="2"
inherit eutils toolchain-funcs python games

DESCRIPTION="a free chess database application"
HOMEPAGE="http://scid.sourceforge.net/"
SRC_URI="mirror://sourceforge/scid/${P}.tar.bz2
	mirror://sourceforge/scid/spelling.zip
	mirror://sourceforge/scid/ratings.zip
	mirror://sourceforge/scid/photos.zip
	mirror://sourceforge/scid/scidlet40k.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="=dev-lang/tk-8.5*
	>=sys-libs/zlib-1.1.3
	app-arch/unzip"
RDEPEND="${DEPEND}
	!games-board/chessdb"

S=${WORKDIR}/${PN}

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	edos2unix engines/togaII1.2.1a/src/Makefile
	epatch "${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-parallelmake.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		tcl/config.tcl \
		tcl/start.tcl \
		src/scidlet.cpp \
		|| die "sed failed"
	gzip ../ratings.ssp
	python_convert_shebangs -r 2 .
}

src_configure() {
	# configure is not an autotools script
	./configure \
		COMPILE=$(tc-getCXX) \
		LINK="$(tc-getCXX) ${LDFLAGS}" \
		CC=$(tc-getCC) \
		OPTIMIZE="${CXXFLAGS}" \
		TCL_INCLUDE="" \
		BINDIR="${GAMES_BINDIR}" \
		SHAREDIR="${GAMES_DATADIR}/${PN}" \
		|| die "configure failed"
}

src_compile() {
	emake all_scid || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install_scid || die "emake install failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r sounds || die "failed installing sounds"

	dodoc CHANGES ChangeLog README THANKS TODO
	dohtml help/*.html

	newicon svg/scid_app.svg ${PN}.svg
	make_desktop_entry scid Scid

	cd ..
	doins spelling.ssp \
		|| die "Failed installing spelling.ssp"
	doins ratings.ssp.gz \
		|| die "Failed installing ratings.ssp"
	doins *.spf \
		|| die "Failed installing photos"
	newins scidlet40k.sbk scidlet.sbk \
		|| die "Failed installing scidlet.sbk"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "To enable speech, emerge dev-tcltk/snack"
	elog "To enable some piece sets, emerge dev-tcltk/tkimg"
	elog "To enable Xfcc support, emerge dev-tcltk/tdom"
}
