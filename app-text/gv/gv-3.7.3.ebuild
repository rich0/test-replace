# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gv/gv-3.7.3.ebuild,v 1.1 2012/01/22 19:07:07 ssuominen Exp $

EAPI=4
inherit eutils

DESCRIPTION="Viewer for PostScript and PDF documents using Ghostscript"
HOMEPAGE="http://www.gnu.org/software/gv/"
SRC_URI="mirror://gnu/gv/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="xinerama"

RDEPEND="app-text/ghostscript-gpl
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	>=x11-libs/libXaw3d-1.6
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/libXt
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	x11-proto/xproto"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.7.3-libXaw3d-1.6.patch
}

src_configure() {
	# For $(use_enable unicode international), see bug #372395

	export ac_cv_lib_Xinerama_main=$(usex xinerama)

	econf --enable-scrollbar-code
}

src_install() {
	default

	doicon "${FILESDIR}"/gv_icon.xpm
	make_desktop_entry gv GhostView gv_icon "Graphics;Viewer"
}
