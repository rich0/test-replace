# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/colpack/colpack-1.0.6.ebuild,v 1.1 2012/04/13 03:24:24 bicatali Exp $

EAPI=4

inherit eutils toolchain-funcs autotools

MYPN=ColPack

DESCRIPTION="C++ algorithms for specialized vertex coloring problems"
LICENSE="GPL-3 LGPL-3"
HOMEPAGE="http://www.cscapes.org/coloringpage/software.htm"
SRC_URI="http://www.cscapes.org/download/${MYPN}/${MYPN}-${PV}.tar.gz"

SLOT="0"
IUSE="openmp static-libs"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYPN}-${PV}"

pkg_setup() {
	if use openmp &&
		[[ $(tc-getCC)$ == *gcc* ]] &&
		( [[ $(gcc-major-version)$(gcc-minor-version) -lt 42 ]] ||
			! has_version sys-devel/gcc[openmp] )
	then
		ewarn "You are using gcc and OpenMP is only available with gcc >= 4.2 "
		die "Need an OpenMP capable compiler"
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-flags.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable openmp) \
		$(use_enable static-libs static)
}
