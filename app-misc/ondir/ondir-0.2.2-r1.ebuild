# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ondir/ondir-0.2.2-r1.ebuild,v 1.1 2010/06/15 11:33:11 jlec Exp $

EAPI="3"

inherit toolchain-funcs

DESCRIPTION="program that automatically executes scripts as you traverse directories"
HOMEPAGE="http://swapoff.org/OnDir"
SRC_URI="http://swapoff.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="sys-apps/sed"

src_prepare() {
	sed -i \
		-e "s:\(/man/.*$\):/share\1:g" \
		-e "s:-g:${CFLAGS}:" Makefile || die "sed Makefile failed"
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		PREFIX="${EPREFIX}/usr" \
		CONF="${EPREFIX}/etc/ondirrc" \
		LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" CONF="${EPREFIX}/etc/ondirrc" install || die
	dodoc AUTHORS ChangeLog README INSTALL scripts.tcsh scripts.sh || die
	newdoc ondirrc.eg ondirrc.example || die
	dohtml changelog.html ondir.1.html || die
}
