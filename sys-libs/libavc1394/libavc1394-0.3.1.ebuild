# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libavc1394/libavc1394-0.3.1.ebuild,v 1.9 2004/06/24 23:04:55 agriffis Exp $

DESCRIPTION="libavc1394 is a programming interface for the 1394 Trade Association AV/C (Audio/Video Control) Digital Interface Command Set."
HOMEPAGE="http://sourceforge.net/projects/libavc1394/"
LICENSE="LGPL-2.1"
SRC_URI="mirror://sourceforge/libavc1394/${P}.tar.gz"
S=${WORKDIR}/${P}
IUSE=""
DEPEND=">=sys-libs/libraw1394-0.8"
SLOT="0"
KEYWORDS="x86 ppc"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
