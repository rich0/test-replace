# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/sablotron/sablotron-0.95-r1.ebuild,v 1.6 2002/08/26 12:21:18 seemant Exp $

MY_P="Sablot-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="An XSLT Parser in C++"
SRC_URI="http://www.gingerall.com/perl/rd?url=sablot/${MY_P}.tar.gz"
HOMEPAGE="http://www.gingerall.com/charlie-bin/get/webGA/act/sablotron.act"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=dev-libs/expat-1.95.1" 

src_unpack() {
	unpack ${A}
	cd ${S}/src/engine
	patch -p0 < ${FILESDIR}/${P}-gentoo.patch || die
}

src_compile() {

	local myconf

	use perl && myconf="--enable-perlconnect"

	econf ${myconf} || die
	make || die
}

src_install () {
	einstall || die
	dodoc README* RELEASE
	dodoc src/TODO
}
