# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avr-libc/avr-libc-1.0.2-r1.ebuild,v 1.7 2005/01/01 17:52:05 eradicator Exp $

# MY_P=${P/avr-/}
# SRC_URI="http://savannah.nongnu.org/download/avr-libc/${MY_P}.tar.bz2"

DESCRIPTION="Libc for the AVR microcontroller architecture"
HOMEPAGE="http:////www.nongnu.org/avr-libc/"

# eiter .tar.gz or tar.bz2
SRC_URI="http://savannah.nongnu.org/download/avr-libc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND="dev-embedded/avr-gcc"

src_compile() {
	mkdir obj-avr
	cd obj-avr
	export CC=avr-gcc
	export CFLAGS=""
	../configure \
		--target=avr \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		`use_enable nls` || die "./configure failed"

	emake || die
}

src_install() {
	cd obj-avr
	einstall || die
}

