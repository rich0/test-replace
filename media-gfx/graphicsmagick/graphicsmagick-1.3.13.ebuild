# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphicsmagick/graphicsmagick-1.3.13.ebuild,v 1.7 2012/03/25 15:40:54 armin76 Exp $

EAPI=4
inherit eutils toolchain-funcs

MY_P=${P/graphicsm/GraphicsM}

DESCRIPTION="Collection of tools and libraries for many image formats"
HOMEPAGE="http://www.graphicsmagick.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="bzip2 cxx debug fpx imagemagick jbig jpeg jpeg2k lcms lzma modules openmp perl png q16 q32 static-libs svg threads tiff truetype wmf X zlib"

RDEPEND="app-text/ghostscript-gpl
	>=sys-devel/libtool-2.2.6b
	bzip2? ( app-arch/bzip2 )
	fpx? ( media-libs/libfpx )
	imagemagick? ( !media-gfx/imagemagick )
	jbig? ( media-libs/jbigkit )
	jpeg? ( virtual/jpeg )
	jpeg2k? ( >=media-libs/jasper-1.701.0 )
	lcms? ( media-libs/lcms:2 )
	lzma? ( app-arch/xz-utils )
	perl? ( dev-lang/perl )
	png? ( >=media-libs/libpng-1.2:0 )
	svg? ( dev-libs/libxml2 )
	tiff? ( >=media-libs/tiff-3.8.2:0 )
	truetype? ( >=media-libs/freetype-2.0 )
	wmf? ( media-libs/libwmf )
	X? (
		x11-libs/libSM
		x11-libs/libXext
		)
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-lzma_configure.patch
}

src_configure() {
	local depth=8
	use q16 && depth=16
	use q32 && depth=32

	local openmp=disable
	if use openmp && tc-has-openmp; then
		openmp=enable
	fi

	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html \
		--${openmp}-openmp \
		--enable-largefile \
		--enable-shared \
		$(use_enable static-libs static) \
		$(use_enable debug ccmalloc) \
		$(use_enable debug prof) \
		$(use_enable debug gcov) \
		$(use_enable imagemagick magick-compat) \
		$(use_with threads) \
		--without-included-ltdl \
		$(use_with modules) \
		--with-quantum-depth=${depth} \
		--without-frozenpaths \
		$(use_with cxx magick-plus-plus) \
		$(use_with perl) \
		--with-perl-options=INSTALLDIRS=vendor \
		$(use_with bzip2 bzlib) \
		$(use_with fpx) \
		--without-gslib \
		$(use_with jbig) \
		$(use_with jpeg) \
		$(use_with jpeg2k jp2) \
		--without-lcms \
		$(use_with lcms lcms2) \
		$(use_with lzma) \
		$(use_with png) \
		$(use_with tiff) \
		$(use_with truetype ttf) \
		$(use_with wmf) \
		--with-fontpath="${EPREFIX}"/usr/share/fonts \
		--with-gs-font-dir="${EPREFIX}"/usr/share/fonts/default/ghostscript \
		--with-windows-font-dir="${EPREFIX}"/usr/share/fonts/corefonts \
		$(use_with svg xml) \
		$(use_with zlib) \
		$(use_with X x)
}

src_compile() {
	emake
	use perl && emake perl-build
}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${D}" install

	if use perl; then
		emake -C PerlMagick DESTDIR="${D}" install
		find "${ED}" -type f -name perllocal.pod -delete
		find "${ED}" -depth -mindepth 1 -type d -empty -delete
	fi

	find "${ED}" -name '*.la' -exec sed -i -e "/^dependency_libs/s:=.*:='':" {} +
}
