# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext-lexicon/locale-maketext-lexicon-0.75.ebuild,v 1.1 2008/11/25 10:56:37 tove Exp $

MODULE_AUTHOR=DRTECH
MY_PN=Locale-Maketext-Lexicon
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

inherit perl-module

DESCRIPTION="Use other catalog formats in Maketext"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/perl-locale-maketext
	dev-lang/perl"

SRC_TEST="do"
