# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/setmixer/setmixer-19941227_rc7.ebuild,v 1.1 2003/01/04 09:44:38 vapier Exp $

inherit eutils

MY_PV="27DEC94"
DEB_REV="7"
DESCRIPTION="command mode mixer"
HOMEPAGE="http://packages.debian.org/testing/sound/setmixer.html"
SRC_URI="http://http.us.debian.org/debian/pool/main/s/setmixer/setmixer_${MY_PV}.orig.tar.gz
	http://http.us.debian.org/debian/pool/main/s/setmixer/setmixer_${MY_PV}-${DEB_REV}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

S=${WORKDIR}/${PN}-${MY_PV}.orig

src_unpack() {
	unpack ${A}
	epatch ${PN}_${MY_PV}-${DEB_REV}.diff
}

src_compile() {
	emake CFLAGS="${CFLAGS}" clean setmixer || die
}

src_install() {
	dobin setmixer
	dodoc README setmixer.lsm
	doman setmixer.1
	insinto /etc ; doins debian/setmixer.conf
	exeinto /etc/init.d ; newexe ${FILESDIR}/setmixer.rc setmixer
}
