# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmcal/libmcal-0.7-r1.ebuild,v 1.9 2004/05/20 06:22:16 robbat2 Exp $

inherit eutils

DESCRIPTION="Modular Calendar Access Libary"
HOMEPAGE="http://mcal.chek.com/"
SRC_URI="mirror://sourceforge/libmcal/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha hppa ~mips amd64 ia64 s390"
IUSE=""

DEPEND=""
RDEPEND=""
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fpic.patch
}

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	einstall DESTDIR=${D} || die
	dodoc CHANGELOG FAQ-MCAL FEATURE-IMPLEMENTATION HOW-TO-MCAL README
	dohtml FUNCTION-REF.html
}
