# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/geos/geos-3.2.0.ebuild,v 1.5 2011/02/26 15:06:57 armin76 Exp $

EAPI=2

DESCRIPTION="Geometry engine library for Geographic Information Systems"
HOMEPAGE="http://trac.osgeo.org/geos/"
SRC_URI="http://download.osgeo.org/geos/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris"
IUSE="doc python ruby"

RDEPEND="ruby? ( =dev-lang/ruby-1.8* )
	python? ( virtual/python )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	ruby?  ( dev-lang/swig )
	python? ( dev-lang/swig )"

src_prepare() {
	# quick fix not worth for eautoreconf
	sed -i \
		-e 's|\/lib\/python|$libdir\/python|g' \
		-e 's|.get_python_lib(0|.get_python_lib(1|g' \
		configure || die
}

src_configure() {
	econf $(use_enable python) $(use_enable ruby)
}

src_compile() {
	emake || die "emake failed"
	if use doc; then
		cd "${S}/doc"
		emake doxygen-html || die "doc generation failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}"usr/lib*/python*/site-packages/geos/_geos.*a || die
	dodoc AUTHORS NEWS README TODO
	if use doc; then
		cd "${S}/doc"
		dohtml -r doxygen_docs/html/* || die
	fi
}
