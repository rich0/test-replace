# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/amsn-skins/amsn-skins-20040223.ebuild,v 1.5 2004/06/24 23:23:53 agriffis Exp $

S=${WORKDIR}
DESCRIPTION="Collection of AMSN themes"
HOMEPAGE="http://amsn.sourceforge.net/"
THEME_URI="mirror://sourceforge/amsn/"
SRC_URI="${THEME_URI}/aMac.zip
	${THEME_URI}/Bolos.zip
	${THEME_URI}/crystola.zip
	${THEME_URI}/cubic.zip
	${THEME_URI}/Fluox.zip
	${THEME_URI}/MSN.zip"
RESTRICT="nomirror"
SLOT="0"
LICENSE="freedist"
KEYWORDS="~x86 ~alpha ppc"
IUSE=""

DEPEND=""
RDEPEND="net-im/amsn"

src_install () {
	dodir /usr/share/amsn/skins
	cp -r ${S}/* ${D}/usr/share/amsn/skins/
}
