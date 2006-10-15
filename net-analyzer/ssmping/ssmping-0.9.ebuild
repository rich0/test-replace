# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ssmping/ssmping-0.9.ebuild,v 1.2 2006/10/15 12:26:25 tcort Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Tool for testing multicast connectivity"
HOMEPAGE="http://www.venaas.no/multicast/ssmping/"
SRC_URI="http://www.venaas.no/multicast/ssmping/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	dobin ssmping asmping
	dosbin ssmpingd
	doman ssmping.1 asmping.1
}
