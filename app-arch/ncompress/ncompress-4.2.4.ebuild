# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/ncompress/ncompress-4.2.4.ebuild,v 1.10 2002/12/09 04:17:37 manson Exp $

DESCRIPTION="Another uncompressor for compatibility"
SRC_URI="ftp://ftp.leo.org/pub/comp/os/unix/linux/sunsite/utils/compress/${P}.tar.gz"
HOMEPAGE="ftp://ftp.leo.org/pub/comp/os/unix/linux/sunsite/utils/compress/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86 ppc sparc  alpha"

src_compile() {
	sed -e "s:options= :options= ${CFLAGS} :" Makefile.def > Makefile
	make || die
}

src_install() {
	dobin compress 
	dosym compress /usr/bin/uncompress
	doman compress.1
}
