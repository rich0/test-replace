# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PlRPC/PlRPC-0.2016-r1.ebuild,v 1.12 2004/05/26 18:47:36 vapier Exp $

inherit perl-module

DESCRIPTION="The Perl RPC Module"
SRC_URI="http://www.cpan.org/modules/by-module/RPC/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/RPC/${P}.readme"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 s390"

DEPEND=">=dev-perl/Storable-1.0.7
	>=dev-perl/Net-Daemon-0.34"
