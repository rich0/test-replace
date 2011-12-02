# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ircii/ircii-20111115.ebuild,v 1.1 2011/12/02 00:17:56 binki Exp $

EAPI=4

inherit eutils

DESCRIPTION="An IRC and ICB client that runs under most UNIX platforms"
SRC_URI="ftp://ircii.warped.com/pub/ircII/${P}.tar.bz2
	ftp://ircii.warped.com/pub/ircII/old/${P}.tar.bz2"
HOMEPAGE="http://eterna.com.au/ircii/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x86-solaris"
IUSE="ipv6"

DEPEND="sys-libs/ncurses
	virtual/libiconv"
# This and irc-client both install /usr/bin/irc #247987
RDEPEND="${DEPEND}
	!!net-irc/irc-client"

src_configure() {
	use elibc_glibc || append-libs -liconv
	econf $(use_enable ipv6)
}

src_install() {
	emake -j1 DESTDIR="${D}" install

	dodoc ChangeLog INSTALL NEWS README \
		doc/Copyright doc/crypto doc/VERSIONS doc/ctcp
}
