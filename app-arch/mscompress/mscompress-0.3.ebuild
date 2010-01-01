# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/mscompress/mscompress-0.3.ebuild,v 1.19 2010/01/01 19:36:13 fauli Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Microsoft compress.exe/expand.exe compatible (de)compressor"
HOMEPAGE="http://gnuwin32.sourceforge.net/packages/mscompress.htm"
SRC_URI="ftp://ftp.penguin.cz/pub/users/mhi/mscompress/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-makefile.patch
	epatch "${FILESDIR}"/${P}-amd64.patch
}

src_compile() {
	tc-export CC
	[ "${ARCH}" == "ppc" ] && append-flags -fsigned-char
	econf || die
	emake || die
}

src_install() {
	dobin mscompress msexpand || die
	doman mscompress.1 msexpand.1
	dodoc README ChangeLog
}
