# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libfame/libfame-0.9.1.ebuild,v 1.4 2004/11/09 03:45:12 vapier Exp $

inherit flag-o-matic gnuconfig gcc eutils

DESCRIPTION="MPEG-1 and MPEG-4 video encoding library"
HOMEPAGE="http://fame.sourceforge.net/"
SRC_URI="mirror://sourceforge/fame/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~sparc ~x86"
IUSE="mmx sse"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Do not add -march=i586, bug #41770.
	sed -i -e 's:-march=i[345]86 ::g' configure

	#closing bug #45736
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		epatch ${FILESDIR}/${P}-mmx_configure.patch
		epatch ${FILESDIR}/${P}-gcc34.patch
	fi

	# This is needed for alpha and probably other newer arches (amd64)
	# (13 Jan 2004 agriffis)
	gnuconfig_update
}

src_compile() {
#	filter-flags -fprefetch-loop-arrays
	econf $(use_enable mmx) $(use_enable sse) || die
	emake || die
}

src_install() {
	dodir /usr
	dodir /usr/lib

	einstall install || die
	dobin libfame-config

	insinto /usr/share/aclocal
	doins libfame.m4

	dodoc CHANGES README
	doman doc/*.3
}
