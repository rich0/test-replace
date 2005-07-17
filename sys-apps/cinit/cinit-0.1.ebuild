# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cinit/cinit-0.1.ebuild,v 1.2 2005/07/17 18:23:00 killerfox Exp $

DESCRIPTION="fast executing, small and simple init with support for profiles"
HOMEPAGE="http://linux.schottelius.org/cinit/"
SRC_URI="http://linux.schottelius.org/cinit/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

DEPEND=""

src_compile() {
	emake \
		OPTIMIZE="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		STRIP=true \
		all || die "all failed"
}

src_install() {
	make install DESTDIR="${D}" || die
	rm -f "${D}"/sbin/init
	dodoc Changelog README TODO `find doc -type f`
}
