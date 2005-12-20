# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/directvnc/directvnc-0.7.5.ebuild,v 1.5 2005/12/20 12:10:23 s4t4n Exp $

inherit eutils

DESCRIPTION="Very thin VNC client for unix framebuffer systems"
HOMEPAGE="http://adam-lilienthal.de/directvnc/"
SRC_URI="http://www.adam-lilienthal.de/directvnc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND="dev-libs/DirectFB
	virtual/x11
	dev-util/pkgconfig
	>=sys-apps/sed-4"

src_compile() {
	econf || die

	# Fix bug #116148, DFBGraphicsDeviceDescription is no longer present in
	# newer DirectFB version, but the application never uses it :-/
	local comment_out="DFBCardCapabilities caps;"
	sed -i -e "s:${comment_out}://${comment_out}:" src/dfb.c

	emake DEBUGFLAGS="${CFLAGS}" || die
}

src_install() {
	make install DESTDIR=${D} || die
	rm -rf ${D}/usr/doc
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO
}
