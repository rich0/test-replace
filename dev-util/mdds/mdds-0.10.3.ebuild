# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs

DESCRIPTION="A collection of multi-dimensional data structure and indexing algorithm"
HOMEPAGE="http://code.google.com/p/multidimalgorithm/"
SRC_URI="http://kohei.us/files/${PN}/src/${P/-/_}.tar.bz2"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="<dev-libs/boost-1.57.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/-/_}

src_configure() {
	econf \
		--with-hash-container=boost \
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
}

src_compile() { :; }

src_test() {
	tc-export CXX
	default
}
