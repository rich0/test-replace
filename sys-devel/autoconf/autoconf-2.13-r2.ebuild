# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf/autoconf-2.13-r2.ebuild,v 1.7 2002/07/10 13:45:38 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Used to create autoconfiguration files"
SRC_URI="ftp://prep.ai.mit.edu/gnu/autoconf/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/autoconf/autoconf.html"
LICENSE="GPL-2"
KEYWORDS="x86"
DEPEND=">=sys-devel/m4-1.4o-r2"

SLOT="2"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-configure-gentoo.diff || die
	patch -p0 < ${FILESDIR}/${P}-configure.in-gentoo.diff || die
}

src_compile() {

	./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--host=${CHOST} || die
		
	make ${MAKEOPTS} || die
}

src_install() {

	make prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		install || die

	exeinto /usr/share/autoconf
	doexe ${S}/install-sh
		
	dodoc COPYING AUTHORS ChangeLog.* NEWS README TODO
}

