# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Builder-Tester/Test-Builder-Tester-1.00.ebuild,v 1.1 2004/07/30 15:51:43 mcummings Exp $

inherit perl-module

DESCRIPTION="Test testsuites that have been built with Test::Builder"
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/MA/MARKF/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~markf/${P}/"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
style="builder"

DEPEND=">=dev-perl/Test-Simple-0.47"
