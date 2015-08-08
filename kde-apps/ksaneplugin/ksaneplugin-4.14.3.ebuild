# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde4-base

DESCRIPTION="SANE Plugin for KDE"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdeapps_dep libksane)
"
RDEPEND="${DEPEND}"
