# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-cdcover/xmms-cdcover-0.2.ebuild,v 1.5 2004/05/10 17:11:32 eradicator Exp $

IUSE=""

DESCRIPTION="An XMMS plugin for viewing album covers"
HOMEPAGE="http://ducts.27b-6.de/cdcover/"
SRC_URI="http://ducts.27b-6.de/cdcover/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="media-sound/xmms
	>=media-libs/gdk-pixbuf-0.2.5"

DOCS="AUTHORS COPYING ChangeLog NEWS README README.skin"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc ${DOCS}
}

pkg_postinst() {
	einfo "Skins can be found at:"
	einfo "http://ducts.27b-6.de/cdcover/"
}
