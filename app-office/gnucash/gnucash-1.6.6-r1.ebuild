# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnucash/gnucash-1.6.6-r1.ebuild,v 1.7 2003/03/16 22:35:48 mholzer Exp $

DESCRIPTION="A personal finance manager"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnucash.org/"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls postgres"

RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	 >=dev-libs/libxml-1.8.3
	 >=gnome-extra/gtkhtml-0.14.0-r1
	 >=gnome-extra/gal-0.13-r1
	 >=gnome-extra/guppi-0.35.5-r2
	 >=gnome-base/gnome-print-0.21
	 postgres? ( dev-db/postgresql )"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	>=dev-libs/slib-2.3.8
	>=dev-lang/swig-1.3_alpha4
	>=dev-libs/g-wrap-1.1.5
	<gnome-base/libglade-2
	media-libs/gdk-pixbuf
	dev-util/guile
	gnome-base/libghttp
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	cd ${S}/src/guile
	cp argv-list-converters.c argv-list-converters.c.old
	sed -e "s,printf,g_print,g" \
		argv-list-converters.c.old > argv-list-converters.c
	rm argv-list-converters.c.old
}

src_compile() {
	local myconf=""

	use nls      || myconf="--disable-nls"
	use postgres && myconf="$myconf --enable-sql"

	# The configure script for this package implements gcc calls that are
	# incompatible with the flag `-fomit-frame-pointer'.
	CFLAGS=${CFLAGS/-fomit-frame-pointer/}
	
	econf --enable-profile \
		--enable-rpc \
		${myconf}

	make || die "Compilation failed" # Doesn't work with make -j 4 (hallski)
}

src_install() {
	einstall
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog HACKING NEWS README* TODO
}
