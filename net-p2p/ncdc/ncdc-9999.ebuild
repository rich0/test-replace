# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ncdc/ncdc-9999.ebuild,v 1.1 2011/10/03 16:38:37 xmw Exp $

EAPI=3

EGIT_REPO_URI="git://g.blicky.net/ncdc.git"

inherit autotools base git-2

DESCRIPTION="ncurses directconnect client"
HOMEPAGE="http://dev.yorhel.nl/ncdc"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="app-arch/bzip2
	dev-libs/glib:2
	dev-libs/libxml2:2
	sys-libs/gdbm
	sys-libs/ncurses:5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/makeheaders"

DOCS=( ChangeLog README )

src_prepare() {
	eautoreconf
}
