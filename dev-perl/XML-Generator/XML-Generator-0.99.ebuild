# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Generator/XML-Generator-0.99.ebuild,v 1.7 2004/05/22 22:57:35 weeve Exp $

inherit perl-module

DESCRIPTION="Perl XML::Generator - A module to help in generating XML documents"
HOMEPAGE="http://www.cpan.org/authors/id/B/BH/BHOLZMAN/"
SRC_URI="http://www.cpan.org/authors/id/B/BH/BHOLZMAN/${P}.tar.gz"

LICENSE="GPL-2 | Artistic"
SLOT="0"
KEYWORDS="sparc x86 ~ppc ~amd64 s390 hppa"
IUSE=""
SRC_TEST="do"

DEPEND="dev-libs/expat"
