# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/monto/monto-0.1.1.ebuild,v 1.1 2010/09/06 09:39:08 s4t4n Exp $

EAPI=2
inherit eutils

DESCRIPTION="This WindowMaker dockapp is a simple manual device mounter (up to four devices)."
HOMEPAGE="http://dockapps.org/file.php/id/274"
SRC_URI="http://dockapps.org/download.php/id/274/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

S="${S}/src"

src_prepare() {
	sed -ie "s/-o monto/\$(LDFLAGS) -o monto/" Makefile
}

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dodoc ../AUTHORS ../NEWS ../README
	dobin ${PN}
}
