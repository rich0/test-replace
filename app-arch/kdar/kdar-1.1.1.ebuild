# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/kdar/kdar-1.1.1.ebuild,v 1.1 2004/06/29 03:40:52 matsuu Exp $

inherit kde
need-kde 3.1

DESCRIPTION="the KDE Disk Archiver"
HOMEPAGE="http://kdar.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdar/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

newdepend ">=app-arch/dar-2.1.0"
