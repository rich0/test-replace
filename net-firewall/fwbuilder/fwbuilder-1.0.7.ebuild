# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/fwbuilder/fwbuilder-1.0.7.ebuild,v 1.5 2003/07/13 11:35:30 mholzer Exp $

DESCRIPTION="A firewall GUI"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"
HOMEPAGE="http://fwbuilder.sourceforge.net/"
S=${WORKDIR}/${P}

KEYWORDS="x86 ~sparc "
LICENSE="GPL-2"
SLOT="0"
IUSE="static nls"

DEPEND="=dev-cpp/gtkmm-1.2*
	>=dev-libs/libxslt-1.0.7
	=net-libs/libfwbuilder-0.10.11
	media-libs/gdk-pixbuf
	dev-libs/libxml2
	=dev-libs/libsigc++-1.0*"
RDEPEND="sys-apps/iproute"

src_compile() {
	local myconf
	myconf="--with-gnu-ld"
	use static	&&	myconf="${myconf} --enable-shared=no --enable-static=yes"
	use nls		||	myconf="${myconf} --disable-nls"

	./autogen.sh \
		--prefix=/usr \
		--host=${CHOST}	|| die "./configure failed"

	cp config.h config.h.orig
	sed -e "s:#define HAVE_XMLSAVEFORMATFILE 1://:" config.h.orig > config.h

	if [ "`use static`" ]
	then
		emake LDFLAGS="-static" || die "emake LDFLAGS failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
}

pkg_postinst() {
	einfo "You may have to install iproute on the machine that"
	einfo "will run the firewall script."
}

