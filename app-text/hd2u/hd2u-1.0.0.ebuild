# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hd2u/hd2u-1.0.0.ebuild,v 1.2 2005/04/23 13:10:47 ka0ttic Exp $

DESCRIPTION="Dos2Unix text file converter"
HOMEPAGE="http://www.megaloman.com/~hany/software/hd2u/"
SRC_URI="http://www.megaloman.com/~hany/_data/hd2u/${P}.tgz"

KEYWORDS="x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~mips ~ia64 ~ppc64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="!app-text/dos2unix
	dev-libs/popt"

src_install() {
	einstall || die "make install failed"
	dodoc AUTHORS COPYING CREDITS ChangeLog INSTALL NEWS README TODO
}
