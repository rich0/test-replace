# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fuse-zip/fuse-zip-0.2.13.ebuild,v 1.1 2010/12/07 14:00:53 hwoarang Exp $

EAPI=2

inherit toolchain-funcs eutils

DESCRIPTION="FUSE file system to navigate, extract, create and modify ZIP archives"
HOMEPAGE="http://code.google.com/p/fuse-zip/"
SRC_URI="http://fuse-zip.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libzip
	sys-fs/fuse"
RDEPEND="${DEPEND}"

RESTRICT="test"

src_prepare() {
	# Fix strip than installing fuse-zip
	sed -i -e 's/install -m 755 -s/install -m 755/' Makefile || die "sed failed"
	# ix broken makefile
	epatch "${FILESDIR}"/"${P}"-as-needed.patch
}

src_compile() {
	emake CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS} ${LDFLAGS}" || die
}

src_install() {
	emake INSTALLPREFIX="${D}"/usr install || die "Failed to install"
	prepalldocs
}
