# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.3.ebuild,v 1.7 2004/04/28 23:31:37 avenj Exp $
inherit kde

# TODO : mysql support
# other refs from configure: jasper, qt-docs, doxygen, libxml2, libxslt, freetype, fontconfig, qt being built with sql support (???)

need-kde 3

DESCRIPTION="A free, integrated office suite for KDE, the K Desktop Environment."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/${P}/src/${P}.tar.bz2"

KEYWORDS="x86 amd64 ~ppc sparc"
RESTRICT="nomirror"

DEPEND="$DEPEND
	>=kde-base/kdelibs-3.1
	>=dev-lang/python-2.2.1
	>=media-libs/libart_lgpl-2.3.9
	>=media-gfx/imagemagick-5.4.5
	>=app-text/wv2-0.1.8
	dev-util/pkgconfig"

src_compile() {
	export LIBPYTHON="`python-config --libs`"
	kde_src_compile
}
