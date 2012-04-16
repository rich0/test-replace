# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/links/links-2.6.ebuild,v 1.8 2012/04/16 17:03:54 ranger Exp $

EAPI=4
inherit autotools eutils fdo-mime

DESCRIPTION="A fast and lightweight web browser running in both graphics and text mode"
HOMEPAGE="http://links.twibright.com/"
SRC_URI="http://${PN}.twibright.com/download/${P}.tar.bz2
	mirror://debian/pool/main/${PN:0:1}/${PN}2/${PN}2_2.5-1.debian.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sh sparc x86 ~ppc-aix ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="bzip2 +deprecated directfb fbcon gpm jpeg livecd lzma ssl suid svga tiff unicode X zlib"

GRAPHICS_DEPEND=">=media-libs/libpng-1.2:0" #75685

RDEPEND=">=sys-libs/ncurses-5.7-r7
	bzip2? ( app-arch/bzip2 )
	directfb? ( dev-libs/DirectFB )
	fbcon? ( ${GRAPHICS_DEPEND} )
	gpm? ( sys-libs/gpm )
	jpeg? ( virtual/jpeg )
	livecd? ( ${GRAPHICS_DEPEND} )
	lzma? ( app-arch/xz-utils )
	ssl? ( dev-libs/openssl:0 )
	svga? (
		${GRAPHICS_DEPEND}
		>=media-libs/svgalib-1.4.3
		)
	tiff? ( media-libs/tiff:0 )
	X? (
		${GRAPHICS_DEPEND}
		x11-libs/libXext
		)
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

GRAPHICS_USE="jpeg gpm"

REQUIRED_USE="fbcon? ( ${GRAPHICS_USE} )
	livecd? ( ${GRAPHICS_USE} )
	svga? ( suid )"

DOCS=( AUTHORS BRAILLE_HOWTO ChangeLog KEYS NEWS README SITES )

src_prepare() {
	epatch "${WORKDIR}"/debian/patches/verify-ssl-certs-510417.diff

	if use unicode; then
		pushd intl >/dev/null
		./gen-intl || die
		./synclang || die
		popd >/dev/null
	fi

	# error: conditional "am__fastdepCXX" was never defined (for eautoreconf)
	sed -i -e '/AC_PROG_CXX/s:#::' configure.in || die

	# Upstream configure produced by broken autoconf-2.13. This also fixes
	# toolchain detection.
	eautoreconf #131440 and #103483#c23
}

src_configure() {
	export ac_cv_lib_gpm_Gpm_Open=$(usex gpm)

	local myconf

	if use X || use fbcon || use directfb || use svga || use livecd; then
		myconf+=' --enable-graphics'
	fi

	if use fbcon || use livecd; then
		myconf+=' --with-fb'
	else
		myconf+=' --without-fb'
	fi

	econf \
		$(use_with ssl) \
		$(use_with zlib) \
		$(use_with bzip2) \
		$(use_with lzma) \
		$(use_with svga svgalib) \
		$(use_with X x) \
		$(use_with directfb) \
		$(use_with jpeg libjpeg) \
		$(use_with tiff libtiff) \
		${myconf}
}

src_install() {
	default

	if use X; then
		newicon Links_logo.png links.png
		make_desktop_entry 'links -g %u' Links links 'Network;WebBrowser'
		local d="${ED}"/usr/share/applications
		echo 'MimeType=x-scheme-handler/http;' >> "${d}"/*.desktop
		use ssl && sed -i -e 's:x-scheme-handler/http;:&x-scheme-handler/https;:' \
			"${d}"/*.desktop
	fi

	nonfatal dohtml doc/links_cal/*
	use deprecated && dosym links /usr/bin/links2
	use suid && fperms 4755 /usr/bin/links
}

pkg_postinst() {
	use X && fdo-mime_desktop_database_update
}

pkg_postrm() {
	use X && fdo-mime_desktop_database_update
}
