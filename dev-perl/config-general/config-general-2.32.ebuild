# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/config-general/config-general-2.32.ebuild,v 1.4 2007/05/05 18:13:33 dertobi123 Exp $


inherit perl-module

MY_P=Config-General-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Config file parser module"
SRC_URI="mirror://cpan/authors/id/T/TL/TLINDEN/${MY_P}.tar.gz"
HOMEPAGE="http://www.daemon.de/config-general/"

SLOT="0"
LICENSE="Artistic"
SRC_TEST="do"

KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 sparc ~x86"
IUSE=""


DEPEND="dev-lang/perl"
