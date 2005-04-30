# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SSLeay/Net-SSLeay-1.25.ebuild,v 1.5 2005/04/30 19:31:09 hansmi Exp $

inherit perl-module

MY_P=${PN/-/_}.pm-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Net::SSLeay module for perl"
HOMEPAGE="http://www.cpan.org/authors/id/SAMPO/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/SAMPO/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips alpha ~arm ~hppa ~amd64 ~ia64 ~s390 ~ppc64"
IUSE=""

DEPEND="dev-libs/openssl"

export OPTIMIZE="$CFLAGS"

myconf="${myconf} /usr"
