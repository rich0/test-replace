# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.1_rc6.ebuild,v 1.1 2003/01/05 13:09:43 hannes Exp $
inherit kde-dist 

IUSE="opengl"
newdepend "opengl? ( virtual/opengl ) ~kde-base/kdebase-${PV}"

DESCRIPTION="KDE artwork package"

KEYWORDS="~x86 ~sparc"

myconf="$myconf --with-dpms"
use opengl && myconf="$myconf --with-gl" || myconf="$myconf --without-gl" 

PATCHES="$FILESDIR/xsaver-conflicting-typedefs.diff"

