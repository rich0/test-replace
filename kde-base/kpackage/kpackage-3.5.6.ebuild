# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpackage/kpackage-3.5.6.ebuild,v 1.2 2007/07/11 01:08:48 mr_bones_ Exp $
KMNAME=kdeadmin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE package manager (deb, rpm etc support; rudimentary ebuild support)"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE="kdehiddenvisibility"
DEPEND=""
