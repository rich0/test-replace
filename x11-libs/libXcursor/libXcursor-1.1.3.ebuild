# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXcursor/libXcursor-1.1.3.ebuild,v 1.1 2005/08/08 04:25:41 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Xcursor library"
#HOMEPAGE="http://foo.bar.com/"
#SRC_URI="ftp://foo.bar.com/${P}.tar.bz2"
#LICENSE=""
#SLOT="0"
KEYWORDS="~x86"
#IUSE="X gnome"
RDEPEND="x11-libs/libXrender
	x11-libs/libXfixes
	x11-libs/libX11"
DEPEND="${RDEPEND}"
