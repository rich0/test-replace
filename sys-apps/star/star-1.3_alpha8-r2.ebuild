# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/star/star-1.3_alpha8-r2.ebuild,v 1.6 2002/10/02 18:20:24 vapier Exp $

A=star-1.3a8.tar.gz
S=${WORKDIR}/star-1.3

DESCRIPTION="An enhanced (world's fastest) tar, as well as enhanced mt/rmt"
SRC_URI="ftp://ftp.fokus.gmd.de/pub/unix/star/alpha/${A}"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/star.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}/DEFAULTS
	cp Defaults.linux Defaults.linux.orig
	sed -e 's:/opt/schily:/usr:g' -e 's:bin:root:g' Defaults.linux.orig > Defaults.linux
}

src_compile() {
	try make COPTX="${CFLAGS}"
}

src_install() {
	try make install INS_BASE=${D}/usr
	insinto /etc/default
	newins ${S}/rmt/rmt.dfl rmt
	#the mt in app-arch/mt-st is better
	rm ${D}/usr/bin/mt ${D}/usr/bin/smt
	dodoc BUILD COPYING Changelog AN-1.* README README.* PORTING TODO
	rm ${D}/usr/man/man1/match*
	dodir /usr/share/
	mv ${D}/usr/man/ ${D}/usr/share
	cd ${D}/usr/bin
	ln -s star ustar
	cd ${D}/usr/sbin
	mv rmt rmt.star
	dosym rmt.star /usr/sbin/rmt
	dosym rmt.1.gz /usr/share/man/man1/rmt.star.1.gz
}


