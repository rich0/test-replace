# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/yaz/yaz-2.0.8.ebuild,v 1.12 2004/11/03 06:42:21 psi29a Exp $

inherit eutils

DESCRIPTION="YAZ is a C/C++ programmer's toolkit supporting the development of Z39.50v3 clients and servers"
HOMEPAGE="http://www.indexdata.dk/${PN}"
SRC_URI="http://ftp.indexdata.dk/pub/${PN}/${P}.tar.gz"
LICENSE="YAZ"
SLOT="0"
KEYWORDS="x86 ppc amd64 alpha ia64 hppa sparc ~mips"
IUSE="tcpd"
RDEPEND="dev-libs/libxml2
		dev-libs/openssl
		tcpd? ( sys-apps/tcp-wrappers )"
DEPEND="${RDEPEND}
		app-text/docbook-xml-dtd
		app-text/docbook-dsssl-stylesheets
		app-text/docbook-xsl-stylesheets
		dev-util/pkgconfig
		sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p1 -d ${S}" \
	epatch ${FILESDIR}/yaz-2.0.19-notcpd-fix.diff
	cd ${S}
	autoconf
}

src_compile() {
	local myopts
	myopts="${myopts} `use_enable tcpd tcpd /usr`"

	econf ${myopts} \
	--enable-shared \
	|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
