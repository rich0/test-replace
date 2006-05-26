# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-meta/kdebindings-meta-3.5.2.ebuild,v 1.3 2006/05/26 18:17:07 wolf31o2 Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdebindings - merge this to pull in all kdebindings-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

# Unslotted packages aren't depended on via deprange
RDEPEND="
>=kde-base/dcopperl-3.5.0_beta2
>=kde-base/dcoppython-3.5.0_beta2
$(deprange $PV $MAXKDEVER kde-base/kalyptus)
$(deprange $PV $MAXKDEVER kde-base/kdejava)
$(deprange $PV $MAXKDEVER kde-base/kjsembed)
>=kde-base/korundum-$PV
$(deprange $PV $MAXKDEVER kde-base/qtjava)
>=kde-base/qtruby-$PV
$(deprange $PV $MAXKDEVER kde-base/smoke)"


# Omitted: qtsharp, dcopc, dcopjava, xparts (considered broken by upstream) 
