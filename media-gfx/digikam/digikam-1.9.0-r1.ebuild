# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-1.9.0-r1.ebuild,v 1.1 2011/05/10 21:00:02 dilfridge Exp $

EAPI=3

KDE_LINGUAS="ar be bg ca ca@valencia cs da de el en_GB eo es et eu fa fi fr ga gl he hi hne hr hu is it ja km
ko lt lv ms nb nds ne nl nn pa pl pt pt_BR ro ru se sk sl sv th tr uk vi zh_CN zh_TW"
KMNAME="extragear/graphics"

# needed for sufficiently new libkdcraw
KDE_MINIMAL="4.5"
inherit kde4-base

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
	handbook? ( mirror://gentoo/${PN}-doc-1.4.0.tar.bz2 )"

LICENSE="GPL-2
	handbook? ( FDL-1.2 )"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="4"
IUSE="addressbook debug doc geolocation gphoto2 handbook mysql semantic-desktop themedesigner +thumbnails video"

CDEPEND="
	>=kde-base/kdelibs-${KDE_MINIMAL}[semantic-desktop?]
	>=kde-base/libkdcraw-${KDE_MINIMAL}
	>=kde-base/libkexiv2-${KDE_MINIMAL}
	>=kde-base/libkipi-${KDE_MINIMAL}
	>=kde-base/solid-${KDE_MINIMAL}
	media-libs/jasper
	virtual/jpeg
	media-libs/lcms:0
	>=media-libs/lensfun-0.2.5
	media-libs/liblqr
	media-libs/libpng
	media-libs/tiff
	media-libs/libpgf
	>=media-plugins/kipi-plugins-1.2.0-r1
	>=sci-libs/clapack-3.2.1-r3
	x11-libs/qt-gui[qt3support]
	|| ( x11-libs/qt-sql[mysql] x11-libs/qt-sql[sqlite] )
	addressbook? ( >=kde-base/kdepimlibs-${KDE_MINIMAL} )
	geolocation? ( >=kde-base/marble-${KDE_MINIMAL}[plasma] )
	gphoto2? ( media-libs/libgphoto2 )
	mysql? ( virtual/mysql )
"
RDEPEND="${CDEPEND}
	>=kde-base/kreadconfig-${KDE_MINIMAL}
	video? (
		|| (
			>=kde-base/mplayerthumbs-${KDE_MINIMAL}
			>=kde-base/ffmpegthumbs-${KDE_MINIMAL}
		)
	)
"
DEPEND="${CDEPEND}
	sys-devel/gettext
	doc? ( app-doc/doxygen )
"

S="${WORKDIR}/${MY_P}"

PATCHES=(
		"${FILESDIR}/${PN}"-1.9.0-docs.patch
		"${FILESDIR}/${PN}"-1.8.0-tests.patch
		"${FILESDIR}/${PN}"-1.9.0-nomysql.patch
	)

src_prepare() {
	if use handbook; then
		mv "${WORKDIR}/${PN}"-1.4.0/* "${S}/" || die
	else
		mkdir doc || die
		echo > doc/CMakeLists.txt || die
	fi

	kde4-base_src_prepare
}

src_configure() {
	local backend

	use semantic-desktop && backend="Nepomuk" || backend="None"
	# LQR = only allows to choose between bundled/external
	mycmakeargs=(
		-DFORCED_UNBUNDLE=ON
		-DWITH_LQR=ON
		-DWITH_LENSFUN=ON
		-DGWENVIEW_SEMANTICINFO_BACKEND=${backend}
		$(cmake-utils_use_with addressbook KdepimLibs)
		$(cmake-utils_use_build doc)
		$(cmake-utils_use_with geolocation MarbleWidget)
		$(cmake-utils_use_enable gphoto2 GPHOTO2)
		$(cmake-utils_use_with gphoto2)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_enable themedesigner)
		$(cmake-utils_use_enable thumbnails THUMBS_DB)
		$(cmake-utils_use_enable mysql MYSQL)
	)

	kde4-base_src_configure
}

src_install() {
	kde4-base_src_install

	if use doc; then
		# install the api documentation
		dodir /usr/share/doc/${PF}/html || die
		insinto /usr/share/doc/${PF}/html
		doins -r ${CMAKE_BUILD_DIR}/api/html/* || die
	fi

	if use handbook; then
		dodoc readme-handbook.txt || die
	fi
}

pkg_postinst() {
	kde4-base_pkg_postinst

	if use doc; then
		elog The digikam api documentation has been installed at /usr/share/doc/${PF}/html
	fi
}
