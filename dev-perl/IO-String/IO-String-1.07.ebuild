# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-String/IO-String-1.07.ebuild,v 1.2 2006/01/13 21:30:07 mcummings Exp $

inherit perl-module

DESCRIPTION="IO::File interface for in-core strings"
HOMEPAGE="http://www.cpan.org/modules/by-module/IO/${P}.readme"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh sparc x86"
IUSE=""

SRC_TEST="do"
