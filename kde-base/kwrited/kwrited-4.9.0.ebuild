# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwrited/kwrited-4.9.0.ebuild,v 1.1 2012/08/01 22:16:51 johu Exp $

EAPI=4
KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="KDE daemon listening for wall and write messages."
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=sys-libs/libutempter-1.1.5
"
RDEPEND="${DEPEND}"
