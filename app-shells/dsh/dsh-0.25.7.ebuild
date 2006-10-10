# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/dsh/dsh-0.25.7.ebuild,v 1.1 2006/10/10 05:23:31 dberkholz Exp $

DESCRIPTION="Distributed Shell"
HOMEPAGE="http://www.netfort.gr.jp/~dancer/software/downloads/"
SRC_URI="http://www.netfort.gr.jp/~dancer/software/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="nls"

DEPEND="dev-libs/libdshconfig"
RDEPEND="${RDEPEND}
	virtual/ssh"

src_compile() {
	econf --sysconfdir=/etc/dsh `use_enable nls` || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodir /etc/dsh/group
	dodoc TODO README ChangeLog
}
