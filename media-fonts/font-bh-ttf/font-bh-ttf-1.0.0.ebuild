# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-bh-ttf/font-bh-ttf-1.0.0.ebuild,v 1.14 2007/06/07 13:11:09 corsair Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Bigelow & Holmes TrueType fonts"

KEYWORDS="alpha ~amd64 arm ~hppa ia64 m68k ~mips ~ppc ppc64 s390 sh sparc ~x86 ~x86-fbsd"

RDEPEND=""
DEPEND="${RDEPEND}
	media-libs/fontconfig
	x11-apps/ttmkfdir"
