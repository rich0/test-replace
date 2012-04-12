# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/clapack/clapack-3.2.1-r6.ebuild,v 1.5 2012/04/12 19:55:43 dilfridge Exp $

EAPI=4

inherit flag-o-matic base cmake-utils

DESCRIPTION="f2c'ed version of LAPACK"
HOMEPAGE="http://www.netlib.org/clapack/"
SRC_URI="http://www.netlib.org/${PN}/${P}-CMAKE.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux"
IUSE="test"

RDEPEND=">=dev-libs/libf2c-20090407-r1
	virtual/blas"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}-CMAKE

PATCHES=(
	"${FILESDIR}/${P}-fix_include_file.patch"
	"${FILESDIR}/${P}-noblasf2c.patch"
	"${FILESDIR}/${P}-hang.patch"
	"${FILESDIR}/${P}-findblas-r6.patch"
)

src_configure() {
	filter-flags -ftree-vectorize
	# causes an internal compiler error with gcc-4.6.2

	local mycmakeargs=( $(cmake-utils_use_enable test TESTS) )
	cmake-utils_src_configure
}
