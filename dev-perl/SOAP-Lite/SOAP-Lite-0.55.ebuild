# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SOAP-Lite/SOAP-Lite-0.55.ebuild,v 1.13 2006/08/05 20:16:01 mcummings Exp $

IUSE=""

inherit perl-module

MY_P=SOAP-Lite-${PV}
DESCRIPTION="Provides a simple and lightweight interface to the SOAP protocol (sic) both on client and server side."

SRC_URI="mirror://cpan/authors/id/B/BY/BYRNE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~byrne/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ppc ~sparc x86"

DEPEND="dev-perl/XML-Parser
	dev-perl/MIME-Lite
	dev-perl/MIME-tools
	dev-lang/perl"
RDEPEND="${DEPEND}"

src_compile() {
	(echo yes) | perl-module_src_compile || perl-module_src_compile || die "compile failed"
	perl-module_src_test || die "test failed"
}

