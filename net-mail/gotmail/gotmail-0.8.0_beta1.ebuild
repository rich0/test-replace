# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/gotmail/gotmail-0.8.0_beta1.ebuild,v 1.4 2004/05/28 19:13:08 g2boojum Exp $

PVPREV=0.7.10
S=${WORKDIR}/${PN}-${PVPREV}
DESCRIPTION="Utility to download mail from a HotMail account"
HOMEPAGE="http://www.nongnu.org/gotmail/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/stable.pkg/${PV}/${PN}_${PVPREV}.tar.gz
	mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

DEPEND="virtual/glibc
	net-misc/curl
	dev-perl/URI
	dev-perl/libnet"

src_unpack() {
	unpack ${A}
	cp ${WORKDIR}/${PN} ${S}
}

src_compile() { :; }

src_install () {
	dobin gotmail || die
	dodoc ChangeLog README sample.gotmailrc
	doman gotmail.1
}
