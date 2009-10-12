# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/komparator/komparator-0.6.ebuild,v 1.2 2009/10/12 09:20:21 abcd Exp $

inherit eutils kde

DESCRIPTION="Komparator is a kde frontend for synchronising directories."
HOMEPAGE="http://komparator.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

need-kde 3.5

src_unpack() {
	kde_src_unpack

	# Fix the desktop file for compliance with the spec.
	sed -i -e 's/%u %u/%U/' "${S}"/src/${PN}.desktop
}
