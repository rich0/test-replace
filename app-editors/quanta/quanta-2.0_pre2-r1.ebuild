# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/quanta/quanta-2.0_pre2-r1.ebuild,v 1.3 2001/11/16 12:50:41 danarmak Exp $
. /usr/portage/eclass/inherit.eclass
inherit kde || die

need-kdelibs 2.1

S=${WORKDIR}/quanta
DESCRIPTION="Quanta - HTML editor for KDE2"

SRC_URI="http://prdownloads.sourceforge.net/quanta/quanta-2.0-pr2.tar.bz2
	 http://prdownloads.sourceforge.net/quanta/css.tar.bz2
	 http://prdownloads.sourceforge.net/quanta/html.tar.bz2
	 http://prdownloads.sourceforge.net/quanta/javascript.tar.bz2
	 http://prdownloads.sourceforge.net/quanta/php.tar.bz2"

HOMEPAGE="http://quanta.sourceforge.net"

src_unpack() {
    base_src_unpack
    kde-objprelink-patch
}

src_install() {
    
    kde_src_install
    
    dodir ${KDEDIR}/share/apps/quanta/doc/
    for x in css html javascript php; do
	cp -a ${WORKDIR}/${x}/*.docrc ${WORKDIR}/${x}/${x} ${D}/${KDEDIR}/share/apps/quanta/doc/
    done
    
}