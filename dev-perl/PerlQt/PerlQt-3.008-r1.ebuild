# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PerlQt/PerlQt-3.008-r1.ebuild,v 1.12 2006/08/05 19:58:46 mcummings Exp $

inherit perl-module kde eutils

#install pqtsh to this directory
myinst="${myinst} INSTBINDIR=${D}/usr/bin"
myconf="--prefix=${D}/usr --enable-smoke --disable-libtool-lock"
mydoc="ChangeLog README TODO INSTALL COPYING AUTHORS"

DESCRIPTION="Perl bindings for the Qt 3.x toolkit"
HOMEPAGE="http://perlqt.sourceforge.net/"

SRC_URI="mirror://sourceforge/perlqt/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

#if kdebindings is installed compilation is really fast!
# because libsmoke comes with kdebindings-3.1

DEPEND="=x11-libs/qt-3*
	dev-lang/perl"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}/PerlQt
	cp Makefile.PL.in Makefile.PL.in.orig
	perl -pi -e "s#WriteMakefile\(#WriteMakefile\(\n'PREFIX' => '${D}/usr',#" Makefile.PL.in
	cd ${S}
	epatch ${FILESDIR}/${P}-fPIC.patch
}

src_compile() {
	addwrite $QTDIR/etc/settings
	perl-module_src_prep

	emake
}

src_install() {

	addwrite $QTDIR/etc/settings
	dodir /lib
	perl-module_src_install

	mkdir -p ${D}/usr/share/doc/${P}/tutorials
	cp -r ${S}/PerlQt/tutorials/* ${D}/usr/share/doc/${P}/tutorials

	for file in `find ${D}/usr/share/doc/${P}/tutorials/*/*.pl`;do
		perl -pi -e "s/use blib;/#use blib;/" ${file}
		chmod +x ${file}
	done

	mkdir -p ${D}/usr/share/doc/${P}/examples
	cp -r ${S}/PerlQt/examples/* ${D}/usr/share/doc/${P}/examples
	for file in `find ${D}/usr/share/doc/${P}/examples/*/*.pl`;do
		chmod +x ${file}
	done
}


