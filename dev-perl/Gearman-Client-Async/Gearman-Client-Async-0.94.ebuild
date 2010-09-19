# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gearman-Client-Async/Gearman-Client-Async-0.94.ebuild,v 1.3 2010/09/19 15:28:12 tove Exp $

EAPI=2

MODULE_AUTHOR=BRADFITZ
inherit perl-module

DESCRIPTION="Asynchronous client module for Gearman for Danga::Socket applications"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-perl/Gearman-1.07
	>=dev-perl/Danga-Socket-1.57"

# testsuite requires gearman server
SRC_TEST="never"
