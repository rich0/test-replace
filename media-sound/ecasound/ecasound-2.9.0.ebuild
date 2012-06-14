# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ecasound/ecasound-2.9.0.ebuild,v 1.1 2012/06/14 06:22:46 radhermit Exp $

EAPI=4
PYTHON_DEPEND="python? 2"

inherit eutils python autotools

DESCRIPTION="a package for multitrack audio processing"
HOMEPAGE="http://ecasound.seul.org/ecasound"
SRC_URI="http://ecasound.seul.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE="alsa audiofile debug doc jack libsamplerate lv2 mikmod ncurses oil osc oss
python ruby sndfile static-libs"

RDEPEND="sys-libs/readline
	alsa? ( media-libs/alsa-lib )
	audiofile? ( media-libs/audiofile )
	jack? ( media-sound/jack-audio-connection-kit )
	libsamplerate? ( media-libs/libsamplerate )
	lv2? ( >=media-libs/lilv-0.5.0 )
	media-libs/ladspa-sdk
	mikmod? ( media-libs/libmikmod:0 )
	ncurses? ( sys-libs/ncurses )
	oil? ( dev-libs/liboil )
	osc? ( media-libs/liblo )
	ruby? ( dev-lang/ruby )
	sndfile? ( media-libs/libsndfile )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	use python && python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.8.1-ldflags.patch

	if use python ; then
		sed -i -e "s:\$(ecasoundc_libs):\0 $(python_get_library -l):" \
			pyecasound/Makefile.am || die "sed failed"
	fi

	eautoreconf
}

src_configure() {
	local pyconf

	if use python ; then
		pyconf="--enable-pyecasound=c
			--with-python-includes=$(python_get_includedir)
			--with-python-modules=$(python_get_libdir)"
	else
		pyconf="--disable-pyecasound"
	fi

	econf \
		--disable-arts \
		--enable-shared \
		--enable-sys-readline \
		--with-largefile \
		$(use_enable alsa) \
		$(use_enable audiofile) \
		$(use_enable debug) \
		$(use_enable jack) \
		$(use_enable libsamplerate) \
		$(use_enable lv2 liblilv) \
		$(use_enable ncurses) \
		$(use_enable oil liboil) \
		$(use_enable osc liblo) \
		$(use_enable oss) \
		$(use_enable ruby rubyecasound) \
		$(use_enable sndfile) \
		$(use_enable static-libs static) \
		${pyconf}
}

src_install() {
	default

	if use doc ; then
		dohtml Documentation/*.html
		dodoc Documentation/programmers_guide/ecasound_programmers_guide.txt
	fi

	prune_libtool_files
}

pkg_postinst() {
	use python && python_mod_optimize ecacontrol.py eci.py pyeca.py
}

pkg_postrm() {
	use python && python_mod_cleanup ecacontrol.py eci.py pyeca.py
}
