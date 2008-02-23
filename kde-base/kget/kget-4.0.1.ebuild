# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kget/kget-4.0.1.ebuild,v 1.2 2008/02/23 17:40:41 ingmar Exp $

EAPI="1"

KMNAME=kdenetwork
inherit kde4-meta

DESCRIPTION="An advanced download manager for KDE"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook +plasma"

DEPEND="
	dev-libs/libpcre
	plasma? ( >=kde-base/plasma-${PV}:${SLOT} )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs} -DWITH_Xmms=OFF
		$(cmake-utils_use_with plasma Plasma)"

	kde4-meta_src_compile
}
