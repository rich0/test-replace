# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Load/Class-Load-0.120.0.ebuild,v 1.3 2011/11/06 19:07:37 maekke Exp $

EAPI=4

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="A working (require q{Class::Name}) and more"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE="test"

RDEPEND="
	virtual/perl-Scalar-List-Utils
	dev-perl/Data-OptList
	>=dev-perl/Module-Runtime-0.11.0
	>=dev-perl/Package-Stash-0.320.0
	dev-perl/Try-Tiny
"
DEPEND="${RDEPEND}
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Fatal
	)"

SRC_TEST="do"
