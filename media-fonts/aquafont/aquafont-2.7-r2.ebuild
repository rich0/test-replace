# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/aquafont/aquafont-2.7-r2.ebuild,v 1.13 2006/11/26 22:04:50 flameeyes Exp $

inherit font

IUSE="X"
MY_P="${PN/font/}${PV/\./_}"

DESCRIPTION="Handwritten Japanese fixed-width TrueType font"
HOMEPAGE="http://aquablue.milkcafe.to/"
SRC_URI="http://aquablue.milkcafe.to/fnt/${MY_P}.lzh"

KEYWORDS="alpha amd64 arm ia64 ppc ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
LICENSE="aquafont"
SLOT=0

S="${WORKDIR}/${MY_P}"
FONT_S="${S}"
FONT_SUFFIX="ttf"

DEPEND="app-arch/lha"
RDEPEND=""

DOCS="readme.txt"

# Only installs fonts
RESTRICT="strip binchecks"

src_unpack(){
	lha e "${DISTDIR}/${MY_P}.lzh"
}
