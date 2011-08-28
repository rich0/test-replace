# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Socket6/Socket6-0.230.0.ebuild,v 1.1 2011/08/28 19:47:02 tove Exp $

EAPI=4

MODULE_AUTHOR=UMEMOTO
MODULE_VERSION=0.23
inherit perl-module

DESCRIPTION="IPv6 related part of the C socket.h defines and structure manipulators"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST="do"

src_unpack() {
	perl-module_src_unpack
	tc-export CC
}
