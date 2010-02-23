# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debootstrap/debootstrap-1.0.22.ebuild,v 1.1 2010/02/23 15:29:45 jer Exp ${PN}/${PN}-1.0.10.ebuild,v 1.1 2008/07/15 17:46:08 jer Exp $

inherit eutils

DESCRIPTION="Debian/Ubuntu bootstrap scripts"
HOMEPAGE="http://packages.qa.debian.org/d/debootstrap.html"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV}.tar.gz mirror://gentoo/devices.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="sys-devel/binutils
	net-misc/wget
	>=app-arch/dpkg-1.14.20"

src_unpack() {
	unpack ${PN}_${PV}.tar.gz
	cp "${DISTDIR}"/devices.tar.gz "${S}"
}

src_compile() {
	return
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc TODO
	doman debootstrap.8
}
