# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-2.2.1-r1.ebuild,v 1.3 2001/11/14 19:21:12 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}Network"

src_unpack() {

    base_src_unpack all
    cd ${S}
    patch -p0 < ${FILESDIR}/${P}-qt-2.3.2.patch || die

}