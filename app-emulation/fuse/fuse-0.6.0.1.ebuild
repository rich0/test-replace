# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/fuse/fuse-0.6.0.1.ebuild,v 1.1 2003/07/16 00:54:33 vapier Exp $

DESCRIPTION="Free Unix Spectrum Emulator by Philip Kendall"
HOMEPAGE="http://www.srcf.ucam.org/~pak21/spectrum/fuse.html"
SRC_URI="http://www.srcf.ucam.org/~pak21/spectrum/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="X svga libdsk"

# This build is heavily use dependent. USE="svga" will build the svga
# version of fuse, otherwise X will be used. Libdsk must be specified
# in order to take advantage of +3 emulation.
DEPEND="dev-lang/perl
	xml2? ( dev-libs/libxml2 )
	png? ( media-libs/libpng )
	zlib? ( sys-libs/zlib )
	>=app-emulation/libspectrum-0.1.0
	|| (
		X? ( virtual/x11 gtk? ( =x11-libs/gtk+-1* ) )
		sdl? ( media-libs/libsdl )
		svga? ( media-libs/svgalib )
		fbcon? ( )
		virtual/x11
	)
	libdsk? ( app-emulation/libdsk
		app-emulation/lib765 )"

src_compile() {
	local guiflag
	if [ `use X` ] ; then
		guiflag="--with-x"
	elif [ `use sdl` ] ; then
		guiflag="--without-x --with-sdl"
	elif [ `use svga` ] ; then
		guiflag="--without-x --with-svgalib"
	elif [ `use fbcon` ] ; then
		guiflag="--without-x --with-fb"
	else
		guiflag="--with-x"
	fi
	#	`use_with plus3-disk libdsk` \
	econf \
		--without-gtk --without-glib \
		--without-plus3-disk \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS README THANKS hacking/*.txt
}
