# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tod Neidt <tod@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+extra/gtk+extra-0.99.17.ebuild,v 1.2 2002/05/23 06:50:19 seemant Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Useful set of widgets for creating GUI's for the Xwindows system using GTK+."

SRC_URI="http://gtkextra.sourceforge.net/src/${P}.tar.gz"

HOMEPAGE="http://gtkextra.sourceforge.net/"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "Configuration Failed"
	
	emake || die "Parallel Make Failed"
	
}

src_install () {

	make DESTDIR=${D} install || die "Installation Failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO

}
