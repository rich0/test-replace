# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-OpenSSL-RSA/Crypt-OpenSSL-RSA-0.13-r1.ebuild,v 1.6 2004/05/24 00:52:59 kloeri Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Crypt::OpenSSL::RSA module for perl"
SRC_URI="http://www.cpan.org/authors/id/I/IR/IROBERTS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/IROBERTS/Crypt-OpenSSL-RSA-${PV}/"
LICENSE="Artistic | GPL-2"
DEPEND="virtual/glibc
	>=dev-lang/perl-5
	dev-perl/Crypt-OpenSSL-Random
	dev-libs/openssl"
KEYWORDS="x86 amd64 alpha"
SLOT="0"

mydoc="rfc*.txt"
