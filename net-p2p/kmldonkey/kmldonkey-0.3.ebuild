# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/kmldonkey/kmldonkey-0.3.ebuild,v 1.5 2003/07/22 20:15:17 vapier Exp $ 

inherit kde-base

need-kde 3

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

S="${WORKDIR}/${P}"
DESCRIPTION="Provides integration for the MLDonkey P2P software and KDE 3"
SRC_URI="http://cvs.gentoo.org/~mholzer/${P}.tar.gz
		mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.gibreel.net/projects/kmldonkey"

