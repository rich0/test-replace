# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Algorithm-Dependency/Algorithm-Dependency-1.101.ebuild,v 1.2 2005/12/02 09:21:16 josejx Exp $

inherit perl-module

DESCRIPTION="Toolkit for implementing dependency systems"
HOMEPAGE="http://search.cpan.org/search?module=${PN}"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Test-ClassAPI
		dev-perl/Params-Util
		>=perl-core/File-Spec-0.82"
