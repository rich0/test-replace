# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-2.4.2.ebuild,v 1.3 2005/09/13 16:03:31 blubb Exp $

MY_P_DOCS="${P/${PN}/${PN}-docs-html}"

DESCRIPTION="Full state iptables firewall"
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://shorewall.net/pub/${PN}/2.4/${P}/${P}.tgz
	doc? ( http://shorewall.net/pub/${PN}/2.4/${P}/${MY_P_DOCS}.tgz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ppc sparc x86"
IUSE="doc"

DEPEND="virtual/libc
	>=net-firewall/iptables-1.2.4
	sys-apps/iproute2"

src_install() {
	keepdir /var/lib/shorewall

	PREFIX="${D}" ./install.sh || die "install.sh failed"
	doinitd ${FILESDIR}/shorewall || die "doinitd failed"

	dodoc COPYING INSTALL changelog.txt releasenotes.txt
	if use doc; then
		cd ${WORKDIR}/${MY_P_DOCS}
		dohtml -r *
		dosym Documentation_Index.html /usr/share/doc/${PF}/html/index.htm
	fi
}

pkg_postinst() {
	einfo
	if use doc ; then
		einfo "Documentation is available at /usr/share/doc/${PF}/html"
	else
		einfo "Documentation is available at http://www.shorewall.net"
	fi

	einfo "Do not blindly start shorewall, edit the files in /etc/shorewall first"
	einfo "At the very least, you must change 'STARTUP_ENABLED' in shorewall.conf"
	einfo
	einfo "If you intend to use the 2.6 IPSEC Support, you must retrieve the"
	einfo "kernel patches from http://shorewall.net/pub/shorewall/contrib/IPSEC/"
	einfo
}
