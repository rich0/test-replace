# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/logrotate/logrotate-3.5.9.ebuild,v 1.3 2002/07/06 18:49:03 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Rotates, compresses, and mails system logs"
SRC_URI="http://ftp.debian.org/debian/pool/main/l/${PN}/${PN}_${PV}.orig.tar.gz"
	
HOMEPAGE="http://packages.debian.org/unstable/admin/logrotate.html"
LICENSE="GPL-2"

DEPEND=">=dev-libs/popt-1.5"
RDEPEND="net-mail/mailx"

src_compile() {
	cp Makefile Makefile.orig
	sed -e "s:CFLAGS += -g:CFLAGS += -g ${CFLAGS}:" Makefile.orig > Makefile
	make || die
}

src_install() {

	insinto /usr
	dosbin logrotate
	doman logrotate.8
	dodoc examples/logrotate*

}
