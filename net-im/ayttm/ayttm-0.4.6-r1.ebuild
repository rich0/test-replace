# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ayttm/ayttm-0.4.6-r1.ebuild,v 1.1 2004/07/01 11:37:03 usata Exp $

# arts causes segfault
IUSE="truetype esd gnome nls"

DESCRIPTION="Are you talking to me? - MSN, Jabber, IRC, ICQ, AIM, SMTP instant messenger"
SRC_URI="mirror://sourceforge/${PN}/${P}-17.tar.bz2"
HOMEPAGE="http://ayttm.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc -alpha"

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	media-libs/audiofile
	media-libs/gdk-pixbuf
	dev-libs/openssl
	app-text/aspell
	sys-devel/libtool
	truetype? ( virtual/xft )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.7 )
	esd? ( >=media-sound/esound-0.2.28 )"

src_compile() {

	econf \
		--enable-smtp \
		--disable-arts \
		`use_enable truetype xft` \
		`use_enable esd` \
		`use_enable gnome` \
		`use_enable nls` || die
	emake || die

}

src_install () {

	einstall || die
	dodoc AUTHORS NEWS README TODO ChangeLog

}
