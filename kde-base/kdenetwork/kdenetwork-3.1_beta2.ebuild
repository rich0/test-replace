# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.1_beta2.ebuild,v 1.3 2002/10/16 19:10:17 bjb Exp $
inherit kde-dist 

DESCRIPTION="KDE $PV - network apps: kmail..."
KEYWORDS="x86 alpha"

src_install() {

    kde_src_install
    
    chmod +s ${D}/${KDEDIR}/bin/reslisa
    
    # empty config file needed for lisa to work with default settings
    touch ${D}/etc/lisarc
    
    # lisa, reslisa initscripts
    dodir /etc/init.d
    sed -e "s:_KDEDIR_:${KDEDIR}:g" ${FILESDIR}/lisa > ${D}/etc/init.d/lisa
    sed -e "s:_KDEDIR_:${KDEDIR}:g" ${FILESDIR}/reslisa > ${D}/etc/init.d/reslisa
    chmod +x ${D}/etc/init.d/*
    
    insinto /etc/conf.d
    newins ${FILESDIR}/lisa.conf lisa
    newins ${FILESDIR}/reslisa.conf reslisa

}

