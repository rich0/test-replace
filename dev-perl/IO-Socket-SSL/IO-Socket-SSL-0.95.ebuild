# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Socket-SSL/IO-Socket-SSL-0.95.ebuild,v 1.5 2004/05/28 02:51:41 vapier Exp $

inherit perl-module

DESCRIPTION="Nearly transparent SSL encapsulation for IO::Socket::INET"
HOMEPAGE="http://search.cpan.org/author/BEHROOZI/${P}/README"
SRC_URI="http://cpan.valueclick.com/authors/id/B/BE/BEHROOZI/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips alpha arm ~amd64 ia64 s390"

DEPEND="dev-perl/Net-SSLeay"
