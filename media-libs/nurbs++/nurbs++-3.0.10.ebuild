# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/nurbs++/nurbs++-3.0.10.ebuild,v 1.8 2003/02/13 12:52:57 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="NURBS surfaces manipulation library"
SRC_URI="http://yukon.genie.uottawa.ca/~lavoie/software/nurbs/${P}.tar.bz2"
HOMEPAGE="http://yukon.genie.uottawa.ca/~lavoie/software/nurbs/"


SLOT="3"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc "

DEPEND="virtual/x11
	sys-devel/perl"
	#media-gfx/imagemagick # doesn't work yet either
	# opengl? ( virtual/opengl ) # doesn't work yet

src_compile() {

	#use opengl \
	#	&& myconf="$myconf --with-opengl=/usr" \
	#	|| myconf="$myconf --without-opengl"
	[ -n "$DEBUG" ] \
		&& myconf="${myconf} \
			--enable-debug \
			--enable-exception \
			--enable-verbose-exception" \
		||  myconf="${myconf} \
			--disable-debug \
			--disable-exception \
			--disable-verbose-exception"

	./configure --with-x --prefix=/usr ${myconf} || die # --with-magick
		
	make || die

}

src_install() {

	make DESTDIR=${D} install || die
		
	dodoc AUTHORS COPYING ChangeLog NEWS README

}
