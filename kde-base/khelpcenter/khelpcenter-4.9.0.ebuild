# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khelpcenter/khelpcenter-4.9.0.ebuild,v 1.1 2012/08/01 22:16:49 johu Exp $

EAPI=4

KDE_HANDBOOK="always"
KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Help Center"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdesu)
	>=www-misc/htdig-3.2.0_beta6-r1
"

KMEXTRA="
	doc/documentationnotfound/
	doc/glossary/
	doc/onlinehelp/
"
