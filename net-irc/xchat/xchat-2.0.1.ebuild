# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-2.0.1.ebuild,v 1.14 2004/06/24 23:10:12 agriffis Exp $

inherit eutils

IUSE="perl tcltk python ssl gtk mmx ipv6"

S=${WORKDIR}/${P}

DESCRIPTION="X-Chat is a graphical IRC client for UNIX operating systems."
SRC_URI="http://www.xchat.org/files/source/2.0/${P}.tar.bz2"
HOMEPAGE="http://www.xchat.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ppc ~sparc ~alpha"

RDEPEND=">=dev-libs/glib-2.0.3
	>=x11-libs/gtk+-2.0.3
	perl?   ( >=dev-lang/perl-5.6.1 )
	ssl?	( >=dev-libs/openssl-0.9.6d )
	python? ( dev-lang/python )
	tcltk? ( dev-lang/tcl )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( >=sys-devel/gettext-0.10.38 )"

src_compile() {
	local myopts

	use gtk \
		&& myopts="${myopts} --enable-gtkfe" \
		|| myopts="${myopts} --disable-gtkfe"
	use ssl \
		&& myopts="${myopts} --enable-openssl" \
		|| myopts="${myopts} --disable-openssl"
	use perl \
		&& myopts="${myopts} --enable-perl" \
		|| myopts="${myopts} --disable-perl"
	use python \
		&& myopts="${myopts} --enable-python" \
		|| myopts="${myopts} --disable-python"
	use tcltk \
		&& myopts="${myopts} --enable-tcl" \
		|| myopts="${myopts} --disable-tcl"
	use mmx	\
		&& myopts="${myopts} --enable-mmx" \
		|| myopts="${myopts} --disable-mmx"
	use ipv6 \
		&& myopts="${myopts} --enable-ipv6" \
		|| myopts="${myopts} --disable-ipv6"

	# Fix for sock5 vulnerabilty - #46856
	epatch ${FILESDIR}/xc208-fixsocks5.diff

	econf \
		--program-suffix=-2 \
		${myopts} || die "Configure failed"

	emake -j1 || die "Compile failed"
}

src_install() {
	# some magic to create a menu entry for xchat 2
	mv xchat.desktop xchat.desktop.old
	sed -e "s:Exec=xchat:Exec=xchat-2:" -e "s:Name=XChat IRC:Name=XChat 2 IRC:" xchat.desktop.old > xchat.desktop

	einstall install || die "Install failed"

	! has_version "<xchat-2" \
		&& dosym /usr/bin/xchat-2 /usr/bin/xchat

	dodoc AUTHORS COPYING ChangeLog README*
}
