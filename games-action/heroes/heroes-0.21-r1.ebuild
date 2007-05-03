# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/heroes/heroes-0.21-r1.ebuild,v 1.8 2007/05/03 21:18:32 mr_bones_ Exp $

inherit eutils autotools games

data_ver=1.5
snd_trk_ver=1.0
snd_eff_ver=1.0

DESCRIPTION="Heroes Enjoy Riding Over Empty Slabs: similar to Tron and Nibbles"
HOMEPAGE="http://heroes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://sourceforge/${PN}/${PN}-data-${data_ver}.tar.bz2
	mirror://sourceforge/${PN}/${PN}-sound-tracks-${snd_trk_ver}.tar.bz2
	mirror://sourceforge/${PN}/${PN}-sound-effects-${snd_eff_ver}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="sdl nls ggi"

RDEPEND="nls? ( virtual/libintl )
	sdl? ( media-libs/libsdl media-libs/sdl-mixer )
	ggi? ( media-libs/libggi media-libs/libgii media-libs/libmikmod )
	!sdl? ( !ggi? ( media-libs/libsdl media-libs/sdl-mixer ) )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"/${P}
	epatch "${FILESDIR}"/${PV}-cvs-segfault-fix.patch #56118
	epatch "${FILESDIR}/${P}"-gcc4.patch
	sed -i 's:$(localedir):/usr/share/locale:' \
		$(find . -name 'Makefile.in*') \
		|| die "sed failed"
	AT_M4DIR=m4 eautoreconf
}

src_compile() {
	local myconf

	if use sdl || ! use ggi ; then
		myconf="${myconf} --with-sdl --with-sdl-mixer"
	else
		myconf="${myconf} --with-ggi --with-mikmod"
	fi

	local pkg
	for pkg in ${A//.tar.bz2} ; do
		cd "${S}"/${pkg}
		egamesconf \
			--disable-heroes-debug \
			--disable-optimizations \
			$(use_enable nls) \
			${myconf} \
			|| die
		emake || die "unable to compile ${pkg}"
	done
}

src_install() {
	local pkg
	for pkg in ${A//.tar.bz2} ; do
		cd "${S}"/${pkg}
		emake DESTDIR="${D}" install || die "emake install failed"
	done
	prepgamesdirs
}
