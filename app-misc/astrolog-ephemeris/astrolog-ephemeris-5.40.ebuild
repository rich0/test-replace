# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/astrolog-ephemeris/astrolog-ephemeris-5.40.ebuild,v 1.7 2004/11/03 11:57:11 axxo Exp $

DESCRIPTION="ephemeris files for optional extended accuracy of astrolog's calculations"
HOMEPAGE="http://www.astrolog.org/astrolog.htm"
SRC_URI="http://www.astrolog.org/ftp/ephem/ephemall.zip"
LICENSE="astrolog"
SLOT="0"
DEPEND="app-arch/unzip"
# works fine on x86 - runs probably on other architectures, too
KEYWORDS="x86 ppc64 ppc"
IUSE=""

S="${WORKDIR}"

DEPEND="app-misc/astrolog"

src_install() {
	dodir /usr/share/astrolog
	cp * ${D}/usr/share/astrolog
}
