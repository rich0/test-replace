# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXrender/libXrender-0.9.0.ebuild,v 1.8 2005/10/19 04:09:33 geoman Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Xrender library"
#HOMEPAGE="http://foo.bar.com/"
#SRC_URI="ftp://foo.bar.com/${P}.tar.bz2"
#LICENSE=""
#SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~s390 ~sh ~sparc ~x86"
#IUSE="X gnome"
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/renderproto"
