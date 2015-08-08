# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=3

inherit xorg-2

DESCRIPTION="print an XKB keyboard description"
KEYWORDS="amd64 arm hppa ~mips ppc ppc64 s390 sh ~sparc x86"
IUSE=""
RDEPEND="x11-libs/libxkbfile
	x11-libs/libX11"
DEPEND="${RDEPEND}"
