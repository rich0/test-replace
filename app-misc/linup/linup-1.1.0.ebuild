# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/linup/linup-1.1.0.ebuild,v 1.3 2003/06/29 23:17:15 aliz Exp $

DESCRIPTION="Linux Uptime Client"
HOMEPAGE="ftp://ftp.smux.net/people/sena/linup/"
SRC_URI="ftp://ftp.smux.net/people/sena/linup/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/glibc"

S="${WORKDIR}/${PN}"

src_compile() {
	emake || die "compile problem"
}

src_install () {
	dobin linup
	dodoc COPYING README
}

pkg_postinst() {
	einfo "Read /usr/share/doc/${P}/README.gz"
	einfo "on how to run linup."
}
