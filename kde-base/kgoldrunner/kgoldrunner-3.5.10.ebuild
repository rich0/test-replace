# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgoldrunner/kgoldrunner-3.5.10.ebuild,v 1.3 2009/06/03 14:59:44 ranger Exp $
KMNAME=kdegames
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE: KGoldrunner is a game of action and puzzle solving"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND=">=kde-base/libkdegames-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
