# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/ckermit/ckermit-7.0.ebuild,v 1.1 2001/04/25 18:50:01 michael Exp $

#P=
A=cku197.tar.gz
S=${WORKDIR}
DESCRIPTION="C-Kermit is a combined serial and network communication software package offering a consistent, medium-independent, cross-platform approach to connection establishment, terminal sessions, file transfer, character-set translation, numeric and alphanumeric paging, and automation of communication tasks."
SRC_URI="ftp://kermit.columbia.edu/kermit/archives/${A}"
HOMEPAGE="http://www.kermit-project.org/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

src_compile() {
    try make \"KFLAGS=-DCK_SHADOW\" linux
}

src_install () {
    dodir /usr/bin
    dodir /usr/share/man/man1
    dodir /usr/doc/${P}
    try make DESTDIR=${D} BINDIR=/usr/bin MANDIR=/usr/share/man/man1 \
             INFODIR=${D}/usr/doc/${P} MANEXT=1 install
}

