# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MODULE_AUTHOR=SHAY
MODULE_VERSION=1.27
inherit eutils perl-module

DESCRIPTION="A URI Perl Module"

SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="sasl"

RDEPEND="sasl? ( dev-perl/Authen-SASL )"
DEPEND=""

SRC_TEST="do"

src_prepare() {
	cp "${FILESDIR}"/libnet.cfg "${S}"
}
