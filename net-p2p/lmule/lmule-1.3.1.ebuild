# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lmule/lmule-1.3.1.ebuild,v 1.3 2003/07/13 20:28:39 aliz Exp $

IUSE=""

DESCRIPTION="GPL eDonkey clone that doesn't suck"
HOMEPAGE="http://lmule.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86"

DEPEND=">=x11-libs/wxGTK-2.4
	>=sys-libs/zlib-1.1.4"

S=${WORKDIR}/${P}

MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	econf "--with-wx-config=/usr/bin/wx-config"|| die
	emake || die
}

src_install() {
	einstall || die
}
