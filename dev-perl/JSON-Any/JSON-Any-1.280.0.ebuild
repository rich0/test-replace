# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JSON-Any/JSON-Any-1.280.0.ebuild,v 1.1 2011/05/27 10:26:34 tove Exp $

EAPI=4

MODULE_AUTHOR=PERIGRIN
MODULE_VERSION=1.28
inherit perl-module

DESCRIPTION="Wrapper Class for the various JSON classes"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE=""

DEPEND="dev-perl/JSON"
RDEPEND="${DEPEND}"

SRC_TEST=do
