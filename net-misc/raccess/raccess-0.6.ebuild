# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/raccess/raccess-0.6.ebuild,v 1.6 2002/08/14 12:08:08 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Remote Access Session is a security tool to analyze the integrity of systems using a library of publically available (and proven to work) exploits"
SRC_URI="http://salix.org/raccess/${P}.tar.gz"
HOMEPAGE="http://salix.org/raccess/"
KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"
SLOT="0"

DEPEND="sys-devel/gcc"

src_compile() {

  ./configure --prefix=/usr --sysconfdir=/etc/raccess --host=${CHOST}  || die
  make BINFILES="-DLOCATION_BIN_FILES=\\\"/usr/lib/raccess\\\"" CFGFILES="-DLOCATION_CONFIG_FILES=\\\"/etc/raccess\\\"" CFLAGS="-g ${CFLAGS}" all || die
	
}

src_install() {

  dodir /etc/raccess
  dodir /usr/lib/raccess

  mv ${S}/exploits/Makefile ${S}/exploits/Makefile.old
  sed 's/bin\/exploits/lib\/raccess/g' ${S}/exploits/Makefile.old > ${S}/exploits/Makefile

  make prefix=${D}/usr mandir=${D}/usr/share/man sysconfdir=${D}/etc/raccess install  || die

  dodoc AUTHORS COPYING ChangeLog INSTALL NEWS PROJECT_PLANNING README 

}

