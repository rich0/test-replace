# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/flightgear/flightgear-2.8.0.ebuild,v 1.3 2012/09/22 21:26:14 ago Exp $

EAPI=4

inherit games cmake-utils

DESCRIPTION="Open Source Flight Simulator"
HOMEPAGE="http://www.flightgear.org/"
SRC_URI="mirror://flightgear/Source/${P}.tar.bz2 mirror://flightgear/Shared/FlightGear-data-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="debug jpeg +jsbsim larcsim subversion test +udev uiuc +yasim"
#fgpanel - disabled for now, doesn't link
#fgpanel? (
#		media-libs/freeglut
#		media-libs/libpng
#	)

COMMON_DEPEND="
	>=dev-games/openscenegraph-3.0.1[png]
	~dev-games/simgear-${PV}[jpeg?,subversion?]
	sys-libs/zlib
	virtual/opengl
	udev? ( sys-fs/udev )
"
# Most entries below are just buildsystem bugs (deps unconditionally
# inherited from static version of simgear)
DEPEND="${COMMON_DEPEND}
	>=dev-libs/boost-1.37
	media-libs/freealut
	media-libs/openal
	>=media-libs/plib-1.8.5
	jpeg? ( virtual/jpeg )
	subversion? (
		dev-libs/apr
		dev-vcs/subversion
	)
"
RDEPEND="${COMMON_DEPEND}"

DOCS=(AUTHORS ChangeLog NEWS README Thanks)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=${GAMES_PREFIX}
		-DENABLE_FGADMIN=OFF
		-DENABLE_RTI=OFF
		-DFG_DATA_DIR="${GAMES_DATADIR}"/${PN}
		-DSIMGEAR_SHARED=ON
		-DWITH_FGPANEL=OFF
		$(cmake-utils_use jpeg JPEG_FACTORY)
		$(cmake-utils_use_enable jsbsim)
		$(cmake-utils_use_enable larcsim)
		$(cmake-utils_use_enable subversion LIBSVN)
		$(cmake-utils_use test LOGGING)
		$(cmake-utils_use_enable test TESTS)
		$(cmake-utils_use udev EVENT_INPUT)
		$(cmake-utils_use_enable uiuc UIUC_MODEL)
		$(cmake-utils_use_enable yasim)
	)
	#$(cmake-utils_use_with fgpanel)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ../data/*
	newicon package/${PN}.ico ${PN}.ico
	newmenu package/${PN}.desktop ${PN}.desktop

	prepgamesdirs
}
