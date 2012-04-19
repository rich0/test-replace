# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwin/kwin-4.8.1.ebuild,v 1.6 2012/04/19 04:42:06 maekke Exp $

EAPI=4

KMNAME="kde-workspace"
OPENGL_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="KDE window manager"
KEYWORDS="amd64 ~arm x86 ~amd64-linux ~x86-linux"
IUSE="debug gles opengl xinerama"

COMMONDEPEND="
	$(add_kdebase_dep kactivities)
	$(add_kdebase_dep kdelibs opengl)
	$(add_kdebase_dep kephal)
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep liboxygenstyle)
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	>=x11-libs/libXrandr-1.2.1
	x11-libs/libXrender
	opengl? ( >=media-libs/mesa-7.10 )
	gles? (
		|| (  ( >=media-libs/mesa-7.10[egl(+),gles] <media-libs/mesa-7.12[egl(+),gles] )
			>=media-libs/mesa-7.12[egl(+),gles2] )
	)
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="${COMMONDEPEND}
	x11-proto/compositeproto
	x11-proto/damageproto
	x11-proto/fixesproto
	x11-proto/randrproto
	x11-proto/renderproto
	xinerama? ( x11-proto/xineramaproto )
"
RDEPEND="${COMMONDEPEND}
	x11-apps/scripts
"

KMEXTRACTONLY="
	ksmserver/
	libs/kephal/
	libs/oxygen/
"

PATCHES=(
	"${FILESDIR}/${PN}-4.4.2-xinerama_cmake_automagic.patch"
	"${FILESDIR}/${PN}-4.8.1-fix-opengl-disabled-build.patch"
)

# you need one of these
REQUIRED_USE="!opengl? ( gles ) !gles? ( opengl )"

src_configure() {
	# FIXME Remove when activity API moved away from libkworkspace
	append-cppflags "-I${EPREFIX}/usr/include/kworkspace"

	mycmakeargs=(
		$(cmake-utils_use_with gles OpenGLES)
		$(cmake-utils_use gles KWIN_BUILD_WITH_OPENGLES)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xinerama X11_Xinerama)
		-DWITH_X11_Xcomposite=ON
	)

	kde4-meta_src_configure
}
