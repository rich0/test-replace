# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/geoip/geoip-1.4.7.ebuild,v 1.1 2011/04/19 22:33:53 jer Exp $

EAPI=2

inherit autotools-utils libtool

MY_P=${P/geoip/GeoIP}
MY_P=${MY_P/_}
DESCRIPTION="easily lookup countries by IP addresses, even when Reverse DNS entries don't exist"
HOMEPAGE="http://www.maxmind.com/geoip/api/c.shtml"
SRC_URI="http://www.maxmind.com/download/geoip/api/c/${MY_P}.tar.gz"

# GPL-2 for md5.c - part of libGeoIPUpdate, MaxMind for GeoLite Country db
LICENSE="LGPL-2.1 GPL-2 MaxMind2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="perl-geoipupdate static-libs"

DEPEND=""
RDEPEND="perl-geoipupdate? ( dev-perl/PerlIO-gzip
	dev-perl/libwww-perl )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -e "s:usr local share GeoIP:usr share GeoIP:" \
		-e "s:usr local etc:etc:" -i apps/geoipupdate-pureperl.pl

	elibtoolize # FreeBSD requires this
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	use perl-geoipupdate && { dobin apps/geoipupdate-pureperl.pl || die; }
	dodoc AUTHORS ChangeLog README TODO conf/GeoIP.conf.default || die
	rm "${D}/etc/GeoIP.conf.default"
	use static-libs || remove_libtool_files
}
