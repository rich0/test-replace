# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvnet/dvnet-0.9.8.ebuild,v 1.6 2004/03/14 12:05:45 mr_bones_ Exp $

S=${WORKDIR}/dvnet-${PV}
DESCRIPTION="dvnet provides an interface wrapping sockets into streams"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvnet/download/dvnet-${PV}.tar.gz"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvnet/html/"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc
	dev-libs/dvutil"
RDEPEND=${DEPEND}

src_install() {
	make DESTDIR=${D} prefix=${D}/usr install
}
