# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nqc/nqc-3.1_p6.ebuild,v 1.4 2012/07/04 19:46:56 jlec Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Not Quite C - C-like compiler for Lego Mindstorms"
HOMEPAGE="http://bricxcc.sourceforge.net/nqc/"
SRC_URI="http://bricxcc.sourceforge.net/nqc/release/${P/_p/.r}.tgz"

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="usb"

DEPEND="usb? ( dev-libs/legousbtower )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc-4.7.patch
	sed \
		-e 's|$(CXX) -o |$(CXX) $(LDFLAGS) -o |g' \
		-e 's|/usr/local|/usr|' \
		-i Makefile \
		|| die "sed Makefile"
}

src_configure() {
	if use usb; then
		sed -i Makefile -e 's|#.*USBOBJ =|USBOBJ =|g' || die "sed usb"
	fi
}

src_compile() {
	emake CXX=$(tc-getCXX) LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin bin/*
	newman nqc-man-2.1r1-0.man nqc.1
	dodoc history.txt readme.txt scout.txt test.nqc
}

pkg_postinst() {
	elog "To change the default serial name for nqc (/dev/ttyS0) set"
	elog "the environment variable RCX_PORT or use the nqc command line"
	elog "option -S to specify your serial port."
	if use usb; then
		echo
		elog "You have enabled USB support. To use usb on the"
		elog "command line use the -Susb command line option"
	else
		echo
		elog "You have not enabled usb support and will be unable"
		elog "to use the usb IR tower. To enable USB use the usb use flag"
	fi
}
