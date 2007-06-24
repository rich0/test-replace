# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xautolock/xautolock-2.1-r1.ebuild,v 1.6 2007/06/24 18:03:05 drac Exp $

DESCRIPTION="An automatic X screen-locker/screen-saver."
SRC_URI="http://www.ibiblio.org/pub/Linux/X11/screensavers/${P}.tgz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/X11/screensavers/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

RDEPEND="|| ( x11-misc/xlockmore
		x11-misc/xtrlock )"
DEPEND="${RDEPEND}
	x11-libs/libXScrnSaver
	x11-misc/imake
	app-text/rman
	x11-proto/scrnsaverproto"

src_compile() {
	xmkmf || die
	emake || die
}

src_install () {
	into /usr
	dobin xautolock || die
	newman xautolock.man xautolock.1
	dodoc Changelog Readme Todo
}
