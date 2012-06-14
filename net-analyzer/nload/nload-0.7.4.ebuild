# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nload/nload-0.7.4.ebuild,v 1.4 2012/06/14 03:22:23 jdhore Exp $

EAPI="4"

DESCRIPTION="console application which monitors network traffic and bandwidth usage in real time"
HOMEPAGE="http://www.roland-riegel.de/nload/index.html"
SRC_URI="http://www.roland-riegel.de/nload/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"
RDEPEND="${DEPEND}"

src_configure() {
	# --enable-debug  do not strip debugging symbols (default no)
	econf --enable-debug
}
