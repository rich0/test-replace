# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/wvstreams/wvstreams-3.70-r2.ebuild,v 1.14 2003/09/26 03:40:01 vapier Exp $

inherit flag-o-matic

DESCRIPTION="A network programming library in C++"
HOMEPAGE="http://open.nit.ca/wiki/?page=WvStreams"
SRC_URI="http://open.nit.ca/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc alpha amd64 hppa"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.patch
	epatch ${FILESDIR}/${PV}-openssl.patch
	if [ "${ARCH}" = "alpha" -o "${ARCH}" = "hppa" ]; then
		sed -i "s:CXXOPTS += :CXXOPTS += -fPIC :" Makefile
	fi
}

src_compile() {
	append-flags -Wno-deprecated
	make || die
}

src_install() {
	make PREFIX=${D}/usr install || die
}
