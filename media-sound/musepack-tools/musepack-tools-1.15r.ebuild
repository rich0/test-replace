# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musepack-tools/musepack-tools-1.15r.ebuild,v 1.1 2004/04/22 09:31:01 eradicator Exp $

inherit eutils

S="${WORKDIR}/sv7"

DESCRIPTION="Musepack audio compression tools"
HOMEPAGE="http://www.uni-jena.de/~pfk/mpp/ http://corecodec.org/projects/mpc/"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
RESTRICT="nomirror"
IUSE="static esd oss"
SRC_URI="http://corecodec.org/download.php/196/mpcsv7-src-${PV}.tar.gz"

RDEPEND="media-sound/esound
	media-libs/id3lib"

DEPEND="${RDEPEND}
	virtual/glibc"

src_unpack() {
	if (! use esd && ! use oss); then
		die "You muse have either oss or esd active in your USE flags for xmms-musepack to work properly."
	fi

	unpack ${A}
	cd ${S}

	#Cosmetic changes mainly to allow using of custom CFLAGS
	epatch ${FILESDIR}/${P}-Makefile.patch

	use oss || sed -i 's/#define USE_OSS_AUDIO/#undef USE_OSS_AUDIO/' mpp.h

	if ! use esd ; then
		sed -i 's/#define USE_ESD_AUDIO/#undef USE_ESD_AUDIO/' mpp.h
		sed -i 's/LDADD   += -lesd/#LDADD   += -lesd/' Makefile
	fi

	use x86 || sed -i 's/#define USE_ASM/#undef USE_ASM/' mpp.h
}

src_compile() {
	filter-flags "-fprefetch-loop-arrays"
	use static && export BLDSTATIC=1
	emake mppenc mppdec replaygain tagger || die
}

src_install() {
	dobin mppenc mppdec replaygain tagger
	dodoc COPYING* README doc/ChangeLog doc/MANUAL.TXT doc/NEWS doc/SV7.txt doc/TODO*
}
