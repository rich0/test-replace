# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Pager/IO-Pager-0.05.ebuild,v 1.2 2005/05/15 19:22:14 josejx Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Select a pager, optionally pipe it output if destination is a TTY"
SRC_URI="mirror://cpan/authors/id/J/JP/JPIERCE/${P}.tgz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/J/JP/JPIERCE/${P}.readme"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~ppc"

