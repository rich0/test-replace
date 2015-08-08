# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit kde4-meta-pkg

DESCRIPTION="kdeaccessibility - merge this to pull in all kdeaccessiblity-derived packages"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_kdeapps_dep jovie)
	$(add_kdeapps_dep kaccessible)
	$(add_kdeapps_dep kmag)
	$(add_kdeapps_dep kmousetool)
	$(add_kdeapps_dep kmouth)
"
