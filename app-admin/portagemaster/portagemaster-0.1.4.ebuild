# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/portagemaster/portagemaster-0.1.4.ebuild,v 1.3 2002/07/17 20:43:17 drobbins Exp $

#S=${WORKDIR}/${PN}
DESCRIPTION="A java portage browser and installer."
SRC_URI="http://portagemaster.sourceforge.net/packages/portagemaster-${PV}.tar.bz2"
SLOT="0"
HOMEPAGE="http://portagemaster.sourceforge.net"
RDEPEND="virtual/jre"
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
}

src_install() {
	dodir /opt/${PN}
	cp portagemaster-${PV}.jar ${D}/opt/${PN}
	
	into /usr
	dobin portagemaster
	ln -s /opt/${PN}/portagemaster-${PV}.jar ${D}/opt/${PN}/portagemaster.jar
}

