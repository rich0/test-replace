# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/utelnetd/utelnetd-0.1.9.ebuild,v 1.2 2004/04/16 20:02:36 randy Exp $

DESCRIPTION="A small Telnet daemon, derived from the Axis tools"
HOMEPAGE="http://www.pengutronix.de/software/utelnetd_en.html"
SRC_URI="http://www.pengutronix.de/software/utelnetd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc s390"
IUSE=""

DEPEND="virtual/glibc"

S=${WORKDIR}/${P}

src_compile() {
	emake CC="${CC}" || die
}

src_install() {
	dosbin utelnetd || die
	dodoc ChangeLog README

	exeinto /etc/init.d; newexe ${FILESDIR}/utelnetd.initd utelnetd
}
