# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fixdos/fixdos-1.3.1.ebuild,v 1.7 2004/03/14 10:59:03 mr_bones_ Exp $

S=${WORKDIR}/fixDos-${PV}
DESCRIPTION="Set of utilities such as crlf which converts files between UNIX and DOS newlines."
HOMEPAGE="http://e.co.za/marius/"
SRC_URI="http://e.co.za/marius/downloads/misc/fixDos-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Apply this patch to the makefile so that it builds with our
	#  desired CFLAGS.
	epatch ${FILESDIR}/${P}-gentoo-makefile.diff
}

src_compile() {
	emake || die
}

src_install () {
	make INSTALLDIR=${D}/usr/bin install || die
}
