# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-itouch/xmms-itouch-0.1.2-r1.ebuild,v 1.5 2004/04/22 06:22:52 eradicator Exp $

IUSE="nls"

DESCRIPTION="XMMS plugin for multimedia keys on Logitech keyboards and others alike"
HOMEPAGE="http://www.saunalahti.fi/~syrjala/xmms-itouch/"
SRC_URI="http://www.saunalahti.fi/~syrjala/xmms-itouch/${P}.tar.gz
	 http://www.saunalahti.fi/~syrjala/xmms-itouch/xmms-itouch.config"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${P}.tar.gz
	ebegin "Applying latest keyboard-models file"
	cp -f ${DISTDIR}/xmms-itouch.config ${P}
	eend

}

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	einfo "To configure the multimedia keys on your keyboard for use with"
	einfo "XMMS, enable this plugin within XMMS and choose a keyboard model"
	einfo "from the list. You can also \"grab\" keys within this"
	einfo "configuration screen. However, for complete freedom of choice "
	einfo "xev is your friend :-)"
}
