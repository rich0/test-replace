# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Writer/XML-Writer-0.602.ebuild,v 1.7 2007/05/05 18:12:57 dertobi123 Exp $

inherit perl-module

DESCRIPTION="XML Writer Perl Module"
HOMEPAGE="http://search.cpan.org/~josephw/XML-Writer-0.600/"
SRC_URI="mirror://cpan/authors/id/J/JO/JOSEPHW/${P}.tar.gz"
IUSE=""
LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 sparc x86"

SRC_TEST="do"


DEPEND="dev-lang/perl"
