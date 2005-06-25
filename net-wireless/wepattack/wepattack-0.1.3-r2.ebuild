# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wepattack/wepattack-0.1.3-r2.ebuild,v 1.2 2005/06/25 13:58:54 swegener Exp $

inherit eutils

MY_P="WepAttack-${PV}"
DESCRIPTION="WLAN tool for breaking 802.11 WEP keys"
HOMEPAGE="http://wepattack.sourceforge.net/"
SRC_URI="mirror://sourceforge/wepattack/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="john"

DEPEND="sys-libs/zlib
	virtual/libpcap
	dev-libs/openssl
	john? ( app-crypt/johntheripper )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-filter-mac-address.patch
	chmod +x src/wlan
	sed -i \
		-e "/^CFLAGS=/s:=:=${CFLAGS} :" \
		-e 's:-fno-for-scope::g' \
		src/Makefile || die "sed Makefile failed"
	sed -i \
		-e "s/wordfile:/-wordlist=/" \
		run/wepattack_word || die "sed wepattack_world faild"
}

src_compile() {
	cd src
	emake || die "emake failed"
}

src_install() {
	dobin src/wepattack || die "dobin failed"
	if use john; then
		dosbin run/wepattack_{inc,word} || die "dosbin failed"
		insinto /etc
		doins ${FILESDIR}/wepattack.conf
	fi
	dodoc README
}
