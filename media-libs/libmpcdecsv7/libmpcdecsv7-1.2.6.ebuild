# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpcdecsv7/libmpcdecsv7-1.2.6.ebuild,v 1.7 2009/08/29 18:19:55 nixnut Exp $

EAPI=2
inherit autotools

DESCRIPTION="Musepack SV7 decoding library (transition package)"
HOMEPAGE="http://www.musepack.net"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-shared \
		--enable-static
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	find "${D}" -name '*.la' -delete
}
