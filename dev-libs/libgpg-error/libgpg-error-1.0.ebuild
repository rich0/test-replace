# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgpg-error/libgpg-error-1.0.ebuild,v 1.12 2004/11/19 11:01:39 dragonheart Exp $

inherit gnuconfig

DESCRIPTION="Contains error handling functions used by GnuPG software"
HOMEPAGE="http://www.gnupg.org/(en)/download/index.html#libgpg-error"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 mips ~ppc ~ppc64 ppc-macos sparc ~x86"
IUSE=""
#IUSE="nls"

DEPEND="virtual/libc"
#RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	gnuconfig_update
}

src_compile() {
	#econf `use_enable nls` || die
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
