# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-DAV/HTTP-DAV-0.460.0.ebuild,v 1.1 2012/01/11 13:22:28 tove Exp $

EAPI=4

MODULE_AUTHOR=COSIMO
MODULE_VERSION=0.46
inherit perl-module

DESCRIPTION="A WebDAV client library for Perl5"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="
	dev-perl/libwww-perl
	dev-perl/URI
	dev-perl/XML-DOM
"
DEPEND="${RDEPEND}"

SRC_TEST="do"
