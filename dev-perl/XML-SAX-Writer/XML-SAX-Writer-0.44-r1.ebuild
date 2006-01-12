# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-SAX-Writer/XML-SAX-Writer-0.44-r1.ebuild,v 1.9 2006/01/12 21:06:54 corsair Exp $

inherit perl-module eutils

DESCRIPTION="SAX2 Writer"
SRC_URI="mirror://cpan/authors/id/R/RB/RBERJON/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rberjon/${P}"

SRC_TEST="do"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/Text-Iconv
	dev-perl/XML-Filter-BufferText
	dev-perl/XML-SAX-Base
	>=dev-perl/XML-NamespaceSupport-1.04
	>=dev-libs/libxml2-2.4.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Text-Iconv.patch || die
}
