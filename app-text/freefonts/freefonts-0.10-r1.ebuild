# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/freefonts/freefonts-0.10-r1.ebuild,v 1.6 2002/10/04 05:05:00 vapier Exp $

S=${WORKDIR}/freefont
DESCRIPTION="A Collection of True Type Fonts"
SRC_URI="ftp://ftp.gimp.org/pub/gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org"
KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="freedist"


src_install () {

	dodir /usr/X11R6/lib/X11/fonts/freefont
	cp -a * ${D}/usr/X11R6/lib/X11/fonts/freefont
	rm  ${D}/usr/X11R6/lib/X11/fonts/freefont/README
	dodoc README

}
