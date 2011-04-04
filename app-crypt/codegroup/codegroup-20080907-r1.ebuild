# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/codegroup/codegroup-20080907-r1.ebuild,v 1.2 2011/04/04 07:15:38 xmw Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="encode / decode binary file as five letter codegroups"
HOMEPAGE="http://www.fourmilab.ch/codegroup/"
SRC_URI="http://www.fourmilab.ch/${PN}/${PN}.zip -> ${P}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin ${PN} || die

	doman ${PN}.1 ||  die
	dodoc ${PN}.{html,jpg} ||  die
}
