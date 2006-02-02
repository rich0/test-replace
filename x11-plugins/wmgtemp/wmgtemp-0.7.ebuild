# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmgtemp/wmgtemp-0.7.ebuild,v 1.8 2006/02/02 16:28:10 nelchael Exp $

IUSE=""

DESCRIPTION="CPU and SYS temperature dockapp"
HOMEPAGE="http://www.fluxcode.net"
SRC_URI="http://www.fluxcode.net/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 -ppc -sparc amd64"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )
	sys-apps/lm_sensors
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}/src
	sed -i -e "s:-Wall -g:\$(CFLAGS):" Makefile
}

src_compile() {
	emake || die "parallel make failed"
}

src_install() {
	cd ${S}
	dodoc BUGS CREDITS README TODO

	cd ${S}/src
	dobin wmgtemp
}
