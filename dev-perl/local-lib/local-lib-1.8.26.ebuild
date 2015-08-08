# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
MODULE_AUTHOR=HAARG
MODULE_VERSION=1.008026
inherit perl-module

DESCRIPTION='create and use a local lib/ for perl modules with PERL5LIB'
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

PATCHES=(
	"${FILESDIR}/${MODULE_VERSION}/0001_No_CPAN.patch"
)

RDEPEND="
	>=virtual/perl-CPAN-1.820.0
	>=virtual/perl-ExtUtils-Install-1.430.0
	>=virtual/perl-ExtUtils-MakeMaker-6.740.0
	>=dev-perl/Module-Build-0.360.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.590.0
"

SRC_TEST="do parallel"
