# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Autouse/Class-Autouse-1.12.ebuild,v 1.5 2005/01/22 13:53:40 gustavoz Exp $

inherit perl-module
DESCRIPTION="Runtime aspect loading of one or more classes"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/Class/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~amd64 alpha ~ppc sparc"
DEPEND="dev-perl/Test-Simple
		dev-perl/ExtUtils-AutoInstall
		dev-perl/module-build
		dev-perl/Scalar-List-Utils"

style="builder"

SRC_TEST="do"
