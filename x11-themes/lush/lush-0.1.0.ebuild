# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 
inherit kde
need-kde 3

S="${WORKDIR}/lush"
DESCRIPTION="Lush KDE icon theme"
SRC_URI="http://projects.dims.org/~dave/distribution/${P}dave.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=5483"
KEYWORDS="x86 ~alpha ppc ~sparc"
SLOT="0"
LICENSE="GPL-1"
IUSE=""

# stripping hangs and we've no binaries
RESTRICT="$RESTRICT nostrip"

src_compile() {
	return 0
}

src_install(){
	cd ${S}
	dodir $PREFIX/share/icons/
	cp -rf ${S} ${D}/${PREFIX}/share/icons
}
