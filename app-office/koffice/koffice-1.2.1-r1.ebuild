# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.2.1-r1.ebuild,v 1.8 2004/04/16 01:15:25 caleb Exp $
inherit kde-base flag-o-matic

filter-flags "-fomit-frame-pointer"

need-kde 3

DESCRIPTION="A free, integrated office suite for KDE, the K Desktop Environment."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/$P/src/$P.tar.bz2"

KEYWORDS="x86 ~ppc sparc ~alpha"

DEPEND="$DEPEND
	>=dev-lang/python-2.2.1
	>=media-libs/libart_lgpl-2.3.9
	>=media-gfx/imagemagick-5.4.5"

PATCHES="$FILESDIR/${P}-kword-crashes.diff"

export LIBPYTHON="`python-config --libs`"
export LIBPYTHON="${LIBPYTHON//-L \/usr\/lib\/python2.2\/config}"
export WANT_AUTOCONF_2_5=1
export WANT_AUTOMAKE_1_5=1

