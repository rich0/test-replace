# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Template-Expr/HTML-Template-Expr-0.05.ebuild,v 1.7 2006/10/09 15:35:52 mcummings Exp $

inherit perl-module

DESCRIPTION="HTML::Template extension adding expression support"
HOMEPAGE="http://cpan.org/modules/by-module/HTML/${P}.readme"
SRC_URI="mirror://cpan/authors/id/S/SA/SAMTREGAR/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-1 GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ia64 sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/HTML-Template
	dev-perl/Parse-RecDescent
		perl-core/Text-Balanced
		virtual/perl-Test-Simple
	dev-lang/perl"
