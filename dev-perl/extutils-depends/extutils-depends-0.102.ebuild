# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/extutils-depends/extutils-depends-0.102.ebuild,v 1.7 2005/01/15 14:03:38 corsair Exp $

inherit perl-module

MY_P=ExtUtils-Depends-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Easily build XS extensions that depend on XS extensions."
HOMEPAGE="http://gtk2-perl.sf.net/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/ML/MLEHMANN/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~alpha hppa ~amd64"
IUSE=""
