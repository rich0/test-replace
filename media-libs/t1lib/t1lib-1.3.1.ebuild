# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/t1lib/t1lib-1.3.1.ebuild,v 1.24 2004/10/07 03:03:46 eradicator Exp $

inherit gnuconfig eutils

IUSE="X"

DESCRIPTION="A Type 1 Font Rasterizer Library for UNIX/X11"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="ftp://metalab.unc.edu/pub/Linux/libs/graphics"

DEPEND="X? ( virtual/x11 )"

SLOT="1"
LICENSE="LGPL-2 GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa amd64"

src_unpack() {
	unpack ${A}
	gnuconfig_update

	cd ${S}/doc
	mv Makefile.in Makefile.in-orig
	sed -e "s:dvips:#dvips:" Makefile.in-orig>Makefile.in

}

src_compile() {

	local myconf
	local myopt

	use X \
		&& myconf="--with-x" \
		|| myconf="--without-x"

	if [ ! -x /usr/bin/latex ] ; then
		myopt="without_doc"
	fi

	echo `pwd`
	econf ${myconf} || die
	make ${myopt} || die
}

src_install() {

	cd lib
	insinto /usr/include
	doins t1lib.h

	use X && ( \
		doins t1libx.h
		ln -s -f libt1x.lai .libs/libt1x.la
		dolib .libs/libt1x.{la,a,so.1.3.1}
		dosym libt1x.so.1.3.1 /usr/$(get_libdir)/libt1x.so.1
		dosym libt1x.so.1.3.1 /usr/$(get_libdir)/libt1x.so
	)

	ln -s -f libt1.lai .libs/libt1.la
	dolib .libs/libt1.{la,a,so.1.3.1}
	dosym libt1.so.1.3.1 /usr/$(get_libdir)/libt1.so.1
	dosym libt1.so.1.3.1 /usr/$(get_libdir)/libt1.so
	insinto /etc/t1lib
	doins t1lib.config

	cd ..
	dodoc Changes LGPL LICENSE README*
	cd doc
	insinto /usr/share/doc/${PF}
	doins *.pdf *.dvi
}
