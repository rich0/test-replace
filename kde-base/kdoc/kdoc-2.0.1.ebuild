# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdoc/kdoc-2.0.1.ebuild,v 1.1 2000/12/07 16:37:17 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="KDE ${PV} - Documentation"
SRC_PATH="kde/stable/${PV}/distribution/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org"

DEPEND=">=sys-devel/perl-5"
RDEPEND=$DEPEND

src_compile() {
    try autoconf
    try ./configure --prefix=/opt/kde2 --host=${CHOST} \
		--with-qt-dir=/usr/lib/qt \
		--with-qt-includes=/usr/lib/qt/include \
		--with-qt-libs=/usr/lib/qt/lib \
		--with-rpm --with-pam
    try make
}

src_install() {

  dodir /opt/kde2/man/man1
  try make install DESTDIR=${D}
  dodoc README TODO Version

}









