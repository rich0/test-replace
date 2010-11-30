# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-ErrorString-Perl/Parse-ErrorString-Perl-0.15.ebuild,v 1.1 2010/11/30 07:54:35 tove Exp $

EAPI=3

MODULE_AUTHOR=AZAWAWI
inherit perl-module

DESCRIPTION="Parse error messages from the perl interpreter"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Class-XSAccessor
	virtual/perl-PodParser
	>=dev-perl/Pod-POM-0.27"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? ( dev-perl/Test-Differences )"

SRC_TEST=do
