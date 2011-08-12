# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/teckit/teckit-2.5.1.ebuild,v 1.18 2011/08/12 10:59:21 tomka Exp $

EAPI="2"

inherit autotools eutils

MY_P=TECkit_${PV//./_}
DESCRIPTION="Text Encoding Conversion toolkit"
HOMEPAGE="http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&cat_id=TECkit"
SRC_URI="http://scripts.sil.org/svn-view/teckit/TAGS/${MY_P}.tar.gz"

LICENSE="|| ( CPL-0.5 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="sys-libs/zlib
	dev-libs/expat"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/${P}-rc.patch"
	epatch "${FILESDIR}/${P}-gcc43.patch"
	epatch "${FILESDIR}/${P}-mixcflagscxxflags.patch"
	rm -f configure
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README NEWS
}

src_test() {
	cd "${S}/test"
	chmod +x dotests.pl
	./dotests.pl || die "tests failed"
}
