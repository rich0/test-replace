# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/readline/readline-4.2a.ebuild,v 1.8 2002/08/14 04:04:40 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Another cute console display library"
SRC_URI="ftp://ftp.gnu.org/gnu/readline/${P}.tar.gz
	 ftp://gatekeeper.dec.com/pub/GNU/readline/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
HOMEPAGE="http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2-r2"

RDEPEND="virtual/glibc"

src_compile() {

	./configure --host=${CHOST} --with-curses \
		--prefix=/usr --mandir=/usr/share/man \
		--infodir=/usr/share/info || die
	emake ${MAKEOPTS} || die
	cd shlib
	emake ${MAKEOPTS} || die

}


src_install() {

	make prefix=${D}/usr mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info install || die
	cd shlib
	make prefix=${D}/usr mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info install || die

	cd ..

	dodir /lib
	mv ${D}/usr/lib/*.so* ${D}/lib
	dosym libhistory.so.${PV/a/} /lib/libhistory.so
	dosym libreadline.so.${PV/a/} /lib/libreadline.so
	# Needed because make install uses ${D} for the link
	dosym libhistory.so.${PV/a/} /lib/libhistory.so.4
	dosym libreadline.so.${PV/a/} /lib/libreadline.so.4
	chmod 755 ${D}/lib/*.${PV/a/}

	dodoc CHANGELOG CHANGES COPYING MANIFEST README USAGE
	docinto ps
	dodoc doc/*.ps
	docinto html
	dodoc doc/*.html

}




