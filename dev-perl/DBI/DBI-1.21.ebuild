# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBI/DBI-1.21.ebuild,v 1.5 2002/07/31 12:43:25 cselkirk Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl DBI Module"
SRC_URI="http://www.cpan.org/modules/by-module/DBI/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/DBI/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc"

DEPEND="${DEPEND}
	>=dev-perl/PlRPC-0.2"

mydoc="ToDo"
