# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-0.7.0.ebuild,v 1.1 2003/11/15 20:57:49 lanius Exp $

inherit kde-base
need-kde 3

DESCRIPTION="amaroK is a media player for KDE"
HOMEPAGE="http://amarok.sourceforge.net/"
SRC_URI="mirror://sourceforge/amarok/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

newdepend "kde-base/kdemultimedia"

src_compile() {
	PREFIX=`kde-config --prefix`
	kde_src_compile myconf configure || die
	make || die
}
