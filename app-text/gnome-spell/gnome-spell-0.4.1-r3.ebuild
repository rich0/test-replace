# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnome-spell/gnome-spell-0.4.1-r3.ebuild,v 1.5 2002/10/04 05:05:24 vapier Exp $

inherit libtool

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Gnome spellchecking component."
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/gnome-spell/${MY_P}.tar.gz"
HOMEPAGE="http://www.gnome.org"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=gnome-base/gnome-libs-1.4.1.7
	>=gnome-base/bonobo-1.0.19-r1
	<gnome-base/libglade-2.0.0
	>=gnome-extra/gal-0.19
	>=app-text/aspell-0.50
	nls? ( sys-devel/gettext )"

src_compile() {

	elibtoolize

	local myconf=""
	if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-nls"
		mkdir intl
		touch intl/libgettext.h
	fi

	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		${myconf} || die

	emake || die
}

src_install() {

	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
