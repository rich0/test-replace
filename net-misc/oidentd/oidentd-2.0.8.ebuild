# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/oidentd/oidentd-2.0.8.ebuild,v 1.3 2007/04/22 16:49:15 phreak Exp $

DESCRIPTION="Another (RFC1413 compliant) ident daemon"
HOMEPAGE="http://dev.ojnk.net/"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="ipv6"

DEPEND=""
RDEPEND=""

src_compile() {
	econf $( use_enable ipv6 ) || die "econf failed!"
	emake || die "emake failed!"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed!"

	dodoc AUTHORS ChangeLog README TODO NEWS \
		"${FILESDIR}"/${PN}_masq.conf "${FILESDIR}"/${PN}.conf

	newinitd "${FILESDIR}"/oidentd-${PV}-init ${PN}
	newconfd "${FILESDIR}"/oidentd-${PV}-confd ${PN}
}

pkg_postinst() {
	echo
	elog "Example configuration files are in /usr/share/doc/${PF}"
	echo
}
