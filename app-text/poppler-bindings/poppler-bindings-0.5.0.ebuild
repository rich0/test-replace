# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/poppler-bindings/poppler-bindings-0.5.0.ebuild,v 1.2 2006/01/20 19:47:55 azarah Exp $

inherit autotools eutils

MY_P=${P/-bindings/}
DESCRIPTION="Poppler bindings are rendering bindings for GUI toolkits for poppler"
HOMEPAGE="http://poppler.freedesktop.org"
SRC_URI="http://poppler.freedesktop.org/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="gtk qt cairo"

RDEPEND=">=app-text/poppler-0.5.0
	cairo? ( >=x11-libs/cairo-0.5 )
	gtk? ( >=x11-libs/gtk+-2.6 )
	qt? ( =x11-libs/qt-3* )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/automake-1.9.6"

S="${WORKDIR}/${MY_P}"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${MY_P}-bindings.patch
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf --disable-poppler-qt4 --enable-opi \
		$(use_enable cairo cairo-output) \
		$(use_enable gtk poppler-glib) \
		$(use_enable qt poppler-qt) \
		|| die "configuration failed"
	emake || die "compilation failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README AUTHORS ChangeLog NEWS README-XPDF TODO
}
