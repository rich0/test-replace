# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/tinystats/tinystats-1.1.ebuild,v 1.1 2006/05/14 14:33:52 bangert Exp $

inherit toolchain-funcs

DESCRIPTION="A tinydns logging helper app."
HOMEPAGE="http://morettoni.net/tinystats.en.html"
SRC_URI="http://morettoni.net/bsd/${P}.tar.gz"
IUSE="ipv6"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86"
RDEPEND="net-dns/djbdns"
S=${WORKDIR}/${PN}

src_compile() {
	use ipv6 && IPV6="-D WITH_IPV6"
	$(tc-getCC) ${CFLAGS} ${IPV6} -o tinystats tinystats.c || \
		die "compile failed"
}

src_install() {
	dobin tinystats
	dodoc README
	docinto sample
	dodoc start_slave.sh.sample update_slave.sh.sample \
		tinydns.log.run.sample tinydns.sh.sample
}
