# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipsc/ipsc-0.4.3.2-r2.ebuild,v 1.2 2009/09/23 19:38:10 patrick Exp $

inherit toolchain-funcs

DESCRIPTION="IP Subnet Calculator"
HOMEPAGE="http://packages.debian.org/unstable/net/ipsc"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:^CC = gcc:CC = $(tc-getCC):" \
		-e "/^CFLAGS = .*/d" \
		-e "s/^LIBS = /LDLIBS = /" \
		-e '/$(CC).*\\$/,+1d' \
		-e '/$(CC)/d' \
		src/Makefile || die "Unable to sed upstream Makefile"
}

src_compile() {
	cd src
	emake || die "Compilation failed"
}

src_install() {
	dodoc README ChangeLog TODO CONTRIBUTORS
	dobin src/ipsc
	doman src/ipsc.1
}
