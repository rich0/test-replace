# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/prothon/prothon-0.0.4_p328.ebuild,v 1.4 2004/07/02 04:30:07 eradicator Exp $

MY_P=${P/_p/-b}
DESCRIPTION="A classless prototype-based programming language with the sensibilities of Python."
HOMEPAGE="http://www.prothon.org/"
SRC_URI="http://www.prothon.org/pub/${PN}/${MY_P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""
DEPEND="virtual/libc
	sys-devel/gcc
	sys-devel/make
	sys-devel/bison
	dev-libs/apr
	dev-libs/boost"

#S=${WORKDIR}/${MY_P/-b/-r}
S=${WORKDIR}/${MY_P}

src_compile() {
	einfo `pwd`
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc CHANGES.txt INSTALL LICENSE README.txt STATUS.txt
}
