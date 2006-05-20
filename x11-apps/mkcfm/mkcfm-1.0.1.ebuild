# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/mkcfm/mkcfm-1.0.1.ebuild,v 1.3 2006/05/20 10:43:29 robbat2 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org mkcfm application"
KEYWORDS="~ppc64 ~x86 ~ppc"
# >=x11-libs/libXfont-0.99.3-r1 for always-on cid support
RDEPEND=">=x11-libs/libXfont-0.99.3-r1
	x11-libs/libX11
	x11-libs/libFS"
DEPEND="${RDEPEND}
	x11-proto/fontsproto"
