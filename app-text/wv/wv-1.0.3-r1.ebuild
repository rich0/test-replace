# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wv/wv-1.0.3-r1.ebuild,v 1.1 2005/10/06 22:14:51 dsd Exp $

inherit eutils

DESCRIPTION="Tool for conversion of MSWord doc and rtf files to something readable"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.gz"
HOMEPAGE="http://wvware.sourceforge.net"

IUSE="xml2 wmf"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~alpha ~ia64 ~amd64 ~ppc64"
SLOT="0"
LICENSE="GPL-2"

RDEPEND="sys-libs/zlib
	dev-libs/glib
	media-libs/libpng
	wmf? ( >=media-libs/libwmf-0.2.2 )
	xml2? ( dev-libs/libxml2 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {

	unpack ${A}

	cd ${S}
	# Fix building with gcc4 (namespace collide with libxml2)
	epatch ${FILESDIR}/${P}-gcc4.patch

	# Open file as readonly
	epatch ${FILESDIR}/${P}-libole2-readonly.patch
}

src_compile() {

	econf \
		`use_with xml2 libxml2` \
		`use_with wmf libwmf` \
		--with-docdir=/usr/share/doc/${PF} \
		|| die

	make || die

}

src_install () {

	einstall

	insinto /usr/include
	doins wvinternal.h

	rm -f ${D}/usr/share/man/man1/wvConvert.1
	dosym  /usr/share/man/man1/wvWare.1 /usr/share/man/man1/wvConvert.1

}
