# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils eutils git-r3 fortran-2 multilib python-single-r1

DESCRIPTION="QT based Computer Aided Design application"
HOMEPAGE="http://www.freecadweb.org/"
EGIT_REPO_URI="https://github.com/FreeCAD/FreeCAD.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

# sci-libs/opencascade ok: failed: 6.9.0
COMMON_DEPEND="dev-cpp/eigen:3
	dev-libs/boost
	dev-libs/xerces-c[icu]
	dev-python/matplotlib
	dev-python/pyside[X]
	dev-python/pyside-tools
	dev-python/shiboken
	dev-qt/designer:4
	dev-qt/qtgui:4
	dev-qt/qtopengl:4
	dev-qt/qtsvg:4
	dev-qt/qtwebkit:4
	media-libs/SoQt
	media-libs/coin[doc]
	net-libs/ptlib
	sci-libs/gts
	|| ( sci-libs/opencascade:6.8.0 sci-libs/opencascade:6.7.1 sci-libs/opencascade:6.6.0 sci-libs/opencascade:6.5.5 )
	sys-libs/zlib
	virtual/glu
	${PYTHON_DEPS}"
RDEPEND="${COMMON_DEPEND}
	dev-qt/assistant:4
	dev-python/pivy
	dev-python/numpy"
DEPEND="${COMMON_DEPEND}
	dev-python/pyside-tools
	>=dev-lang/swig-2.0.4-r1:0"

# http://bugs.gentoo.org/show_bug.cgi?id=352435
# http://www.gentoo.org/foundation/en/minutes/2011/20110220_trustees.meeting_log.txt
RESTRICT="bindist mirror"

# TODO:
#   DEPEND and RDEPEND:
#		salome-smesh - science overlay
#		zipio++ - not in portage yet

pkg_setup() {
	fortran-2_pkg_setup
	python-single-r1_pkg_setup

	[ -z "${CASROOT}" ] && die "empty \$CASROOT, run eselect opencascade set or define otherwise"
}

src_prepare() {
	einfo remove bundled libs
	rm -rf src/3rdParty/{boost,Pivy*}

	epatch "${FILESDIR}"/${PN}-0.14.3702-install-paths.patch

	#bug 518996
	sed -e "/LibDir = /s:'lib':'"$(get_libdir)"':g" \
		-i src/App/FreeCADInit.py || die

}

src_configure() {
	local my_occ_env=${EROOT}etc/env.d/50opencascade
	if [ -e "${EROOT}etc//env.d/51opencascade" ] ; then
		my_occ_env=${EROOT}etc/env.d/51opencascade
	fi
	export CASROOT=$(awk -F '=' '$1 == "CASROOT" {print $2}' $my_occ_env)
	#my_occ_ver=$(echo $CASROOT |
	#	awk '{print gensub(".*opencascade-([0-9.]*).*","\\1","$0")}')
	# or just $(eselect opencascade show)

	local mycmakeargs=(
		-DOCC_INCLUDE_DIR="${CASROOT}"/inc
		-DOCC_INCLUDE_PATH="${CASROOT}"/inc
		-DOCC_LIBRARY="${CASROOT}"/lib/libTKernel.so
		-DOCC_LIBRARY_DIR="${CASROOT}"/lib
		-DOCC_LIB_PATH="${CASROOT}"/lib
		-DCOIN3D_INCLUDE_DIR="${EROOT}"usr/include/coin
		-DCOIN3D_LIBRARY="${EROOT}"usr/$(get_libdir)/libCoin.so
		-DSOQT_LIBRARY="${EROOT}"usr/$(get_libdir)/libSoQt.so
		-DSOQT_INCLUDE_PATH="${EROOT}"usr/include/coin
		-DCMAKE_INSTALL_PREFIX="${EROOT}"usr/$(get_libdir)/${P}
		-DCMAKE_INSTALL_DATADIR="${EROOT}"usr/share/${P}/
		-DCMAKE_INSTALL_DOCDIR="${EROOT}"usr/share/doc/${P}/
		-DCMAKE_INSTALL_INCLUDEDIR="${EROOT}"usr/include/${P}/
		-DFREECAD_USE_EXTERNAL_PIVY="ON"
		-DFREECAD_BUILD_FEM="OFF"
	)

	# TODO to remove embedded dependencies:
	#
	#	-DFREECAD_USE_EXTERNAL_ZIPIOS="ON" -- this option needs zipios++ but it's not yet in portage so the embedded zipios++
	#                (under src/zipios++) will be used
	#	salomesmesh is in 3rdparty but upstream's find_package function is not complete yet to compile against external version
	#                (external salomesmesh is available in "science" overlay)

	cmake-utils_src_configure
	ewarn "${P} will be built against opencascade version ${CASROOT}"
}

src_install() {
	cmake-utils_src_install

	prune_libtool_files

	make_wrapper FreeCAD \
		"${EROOT}"usr/$(get_libdir)/${P}/bin/FreeCAD \
		"" "${EROOT}"usr/$(get_libdir)/${P}/lib
	make_wrapper FreeCADCmd \
		"${EROOT}"usr/$(get_libdir)/${P}/bin/FreeCADCmd \
		"" "${EROOT}"usr/$(get_libdir)/${P}/lib

	newicon src/Main/icon.ico ${PN}.ico
	make_desktop_entry FreeCAD

	dodoc README ChangeLog.txt

	# disable compression of QT assistant help files
	>> "${ED}"usr/share/doc/${P}/freecad.qhc.ecompress.skip
	>> "${ED}"usr/share/doc/${P}/freecad.qch.ecompress.skip

	python_optimize "${ED}"usr/{$(get_libdir),share}/${P}/Mod/
}
