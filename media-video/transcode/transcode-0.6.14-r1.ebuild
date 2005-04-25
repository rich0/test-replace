# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/transcode/transcode-0.6.14-r1.ebuild,v 1.3 2005/04/25 00:45:37 flameeyes Exp $

inherit libtool flag-o-matic eutils multilib

MY_P="${P/_pre/.}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="video stream processing tool"
HOMEPAGE="http://www.transcoding.org/cgi-bin/transcode"
SRC_URI="http://www.jakemsr.com/transcode/${P}.tar.gz
	http://www.ligo.caltech.edu/~pehrens/${P}.tar.gz
	http://www.kraymer.de/mirroring/${P}.tar.gz
	http://rebels.plukwa.net/linux-video/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="X 3dnow a52 avi altivec divx4linux dv dvdread encode fame truetype \
	gtk imagemagick jpeg lzo mjpeg mpeg mmx network oggvorbis pvm quicktime \
	sdl sse sse2 theora v4l xvid xml2"

DEPEND="a52? ( >=media-libs/a52dec-0.7.4 )
	=sys-devel/gcc-3*
	dv? ( >=media-libs/libdv-0.99 )
	x86? ( >=dev-lang/nasm-0.98.36 )
	dvdread? ( >=media-libs/libdvdread-0.9.0 )
	>=media-video/ffmpeg-0.4.9_pre1
	xvid? ( >=media-libs/xvid-1.0.2 )
	mjpeg? ( >=media-video/mjpegtools-1.6.2-r3 )
	lzo? ( >=dev-libs/lzo-1.08 )
	fame? ( >=media-libs/libfame-0.9.1 )
	imagemagick? ( >=media-gfx/imagemagick-5.5.6.0 )
	media-libs/netpbm
	media-libs/libexif
	X? ( virtual/x11 )
	avi? (	>=media-video/avifile-0.7.41.20041001 )
	divx4linux? ( x86? ( >=media-libs/divx4linux-20030428 ) )
	mpeg? ( media-libs/libmpeg3 )
	encode? ( >=media-sound/lame-3.93 )
	sdl? ( media-libs/libsdl )
	quicktime? ( >=media-libs/libquicktime-0.9.3 )
	oggvorbis? ( media-libs/libvorbis
		    media-libs/libogg )
	theora? ( media-libs/libtheora )
	jpeg? ( media-libs/jpeg )
	gtk? ( =x11-libs/gtk+-1.2* )
	truetype? ( >=media-libs/freetype-2 )
	pvm? ( >=sys-cluster/pvm-3.4 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# needed for libquicktime >= 0.9.4, see #85865
	epatch ${FILESDIR}/${P}-libquicktime094.patch

	# apply amd64 and mmx patches from upstream CVS
	epatch ${FILESDIR}/${P}-amd64_mmx.patch

	libtoolize --copy --force || die "libtoolize failed"
	autoreconf -i || die "autoreconf failed"

	elibtoolize	# fix invalid paths in .la files of plugins
}

src_compile() {

	filter-flags -maltivec -mabi=altivec -momit-leaf-frame-pointer
	use ppc && append-flags -U__ALTIVEC__

	if use pvm; then
		if use sparc; then
			myconf="${myconf} --enable-pvm3 \
				--with-pvm3-lib=${PVM_ROOT}/lib/LINUXSPARC \
				--with-pvm3-include=${PVM_ROOT}/include"
		else
			myconf="${myconf} --enable-pvm3 \
				--with-pvm3-lib=${PVM_ROOT}/lib/LINUX \
				--with-pvm3-include=${PVM_ROOT}/include"
		fi
	fi

	use xvid \
		&& myconf="${myconf} --with-default-xvid=xvid4"

	# Use the MPlayer libpostproc if present
	[ -f ${ROOT}/usr/$(get_libdir)/libpostproc.a ] && \
	[ -f ${ROOT}/usr/include/postproc/postprocess.h ] && \
		myconf="${myconf} --with-libpostproc-builddir=${ROOT}/usr/$(get_libdir)"

	append-flags -DDCT_YUV_PRECISION=1
	econf \
		--with-mod-path=/usr/$(get_libdir)/transcode \
		$(use_enable X x) \
		$(use_enable 3dnow) \
		$(use_enable a52) \
		$(use_enable altivec) \
		$(use_enable avi avifile) \
		$(use_enable dv libdv) \
		$(use_enable dvdread libdvdread) \
		$(use_enable encode lame) \
		$(use_enable fame libfame) \
		$(use_enable truetype freetype2) \
		$(use_enable gtk) \
		$(use_enable imagemagick) \
		$(use_enable jpeg libjpeg) \
		$(use_enable lzo) \
		$(use_enable mjpeg mjpegtools) \
		$(use_enable mmx) \
		$(use_enable mpeg libmpeg3) \
		$(use_enable network netstream) \
		$(use_enable oggvorbis ogg) \
		$(use_enable oggvorbis vorbis) \
		$(use_enable quicktime libquicktime) \
		$(use_enable sdl) \
		$(use_enable sse) \
		$(use_enable sse2) \
		$(use_enable theora) \
		$(use_enable v4l) \
		$(use_enable xml2 libxml2) \
		${myconf} \
		|| die

	emake -j1 all || die

	if use pvm; then
		sed -i -e "s:\${exec_prefix}/bin/pvmgs:\$(DESTDIR)/\${exec_prefix}/bin/pvmgs:" ${S}/pvm3/Makefile || die
	fi
}

src_install () {
	make \
		DESTDIR=${D} \
		install || die

	dodoc AUTHORS ChangeLog README TODO
}
