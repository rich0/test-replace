# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ethtool/ethtool-1.7.ebuild,v 1.1 2002/11/10 20:53:40 cretin Exp $

DESCRIPTION="Utility for examining and tuning your ethernet-based network interface"

HOMEPAGE="http://sourceforge.net/projects/gkernel/"

SRC_URI="mirror://sourceforge/gkernel/${P}.tar.gz"

LICENSE="GPL2"

SLOT="0"

KEYWORDS="x86 alpha sparc sparc64 ppc"

IUSE=""

src_install () {
	einstall || die
	dodoc NEWS README INSTALL
}
