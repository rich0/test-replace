# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim-lcd/gpsim-lcd-0.1.1.ebuild,v 1.8 2005/01/01 17:53:12 eradicator Exp $

inherit eutils

MY_PN="${PN/gpsim-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="2x20 LCD display module for GPSIM"
HOMEPAGE="http://www.dattalo.com/gnupic/gpsim.html#modules http://www.dattalo.com/gnupic/lcd.html"
SRC_URI="http://www.dattalo.com/gnupic/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-embedded/gpsim-0.20*"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc33.patch
	epatch ${FILESDIR}/${P}-display_fix.patch
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	cp -ra ${S}/examples ${D}/usr/share/doc/${PF}
	find ${D}/usr/share/doc/${PF} -name 'Makefile*' -exec rm -f \{} \;
}
