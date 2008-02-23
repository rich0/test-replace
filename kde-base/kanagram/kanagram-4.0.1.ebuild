# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kanagram/kanagram-4.0.1.ebuild,v 1.2 2008/02/23 17:36:01 ingmar Exp $

EAPI="1"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="KDE: letter order game."
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	>=kde-base/phonon-${PV}:${SLOT}"

KMEXTRACTONLY="libkdeedu/kdeeduui libkdeedu/keduvocdocument"
