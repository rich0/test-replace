# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/geekcode/geekcode-1.7.3.ebuild,v 1.11 2004/12/27 22:23:03 gongloo Exp $

DESCRIPTION="Geek code generator"
HOMEPAGE="http://geekcode.sourceforge.net/"
SRC_URI="mirror://sourceforge/geekcode/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~mips amd64 ppc64 ppc ~ppc-macos"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin geekcode || die
	dodoc CHANGES README geekcode.txt
}
