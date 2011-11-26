# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libint/libint-1.1.4-r1.ebuild,v 1.6 2011/11/26 09:41:14 hwoarang Exp $

EAPI=4

inherit eutils fortran-2 toolchain-funcs

DESCRIPTION="Matrix elements (integrals) evaluation over Cartesian Gaussian functions"
HOMEPAGE="http://www.chem.vt.edu/chem-dept/valeev/software/libint/libint.html"
SRC_URI="http://www.chem.vt.edu/chem-dept/valeev/software/libint/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="virtual/fortran"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/1.1.4-as-needed.patch
}

src_configure() {
	econf \
		--enable-shared \
		--enable-deriv \
		--enable-r12 \
		--with-cc=$(tc-getCC) \
		--with-cxx=$(tc-getCXX) \
		--with-cc-optflags="${CFLAGS}" \
		--with-cxx-optflags="${CXXFLAGS}"
}

src_compile() {
	emake LDFLAGS="${LDFLAGS}"
}
