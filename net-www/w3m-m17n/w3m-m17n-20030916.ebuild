# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/w3m-m17n/w3m-m17n-20030916.ebuild,v 1.1 2003/09/20 17:51:14 usata Exp $

IUSE="imlib gtk xface gpm ssl ipv6"
#IUSE="nls"

W3M_CVS_PV="1.860"
W3M_P="w3m-cvs-${W3M_CVS_PV}"

W3M_M17N_CVS_PV="1.859"
W3M_M17N_P="w3m-cvs-${W3M_M17N_CVS_PV}-m17n"
LIBWC_PV="20030224"

#GC_PV="6.3alpha1"
#GC_P="gc${GC_PV}"

DESCRIPTION="Lightweight text based WWW browser w3m with multilingual extension"
HOMEPAGE="http://w3m.sourceforge.net/
	http://www2u.biglobe.ne.jp/~hsaka/w3m/
	http://www.page.sannet.ne.jp/knabe/w3m/w3m.html"
SRC_URI="http://dev.gentoo.org/~usata/distfiles/${W3M_P}.tar.gz
	http://www.page.sannet.ne.jp/knabe/w3m/${W3M_M17N_P}-1.diff.gz
	http://dev.gentoo.org/~usata/distfiles/libwc-${LIBWC_PV}.tar.gz"
#	nls? ( http://www.page.sannet.ne.jp/knabe/w3m/${W3M_M17N_P}-nls-1.diff.gz)
#	http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/${GC_P}.tar.gz

SLOT="0"
LICENSE="w3m"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"

DEPEND=">=sys-libs/ncurses-5.2-r3
	>=sys-libs/zlib-1.1.3-r2
	dev-lang/perl
	>=dev-libs/boehm-gc-6.2
	gtk? ( =x11-libs/gtk+-1.2*
		media-libs/gdk-pixbuf )
	!gtk? ( imlib? ( media-libs/imlib
			media-libs/libungif ) )
	xface? ( media-libs/compface )
	gpm? ( >=sys-libs/gpm-1.19.3-r5 )
	ssl? ( >=dev-libs/openssl-0.9.6b )"

PROVIDE="virtual/textbrowser
	virtual/w3m"

S="${WORKDIR}/${W3M_P}"

src_unpack() {

	unpack ${W3M_P}.tar.gz
	cd ${S}

	#unpack ${GC_P}.tar.gz
	#mv ${GC_P} gc

	# libwc doesn't come with w3m-m17n now
	unpack libwc-${LIBWC_PV}.tar.gz

	epatch ${DISTDIR}/${W3M_M17N_P}-1.diff.gz
	#use nls && epatch ${DISTDIR}/${W3M_M17N_P}-nls-1.diff.gz
}

src_compile() {

	local myconf

	if [ -n "`use imlib`" -o -n "`use gtk`" ] ; then
		myconf="${myconf} --enable-image=x11,fb `use_enable xface`"
	else
		myconf="${myconf} --enable-image=no"
	fi

	#	--enable-japanese=m
	econf --program-suffix=-m17n \
		--enable-keymap=w3m \
		--with-editor=/usr/bin/nano \
		--with-mailer=/bin/mail \
		--with-browser=/usr/bin/mozilla \
		--with-termlib=ncurses \
		`use_enable gpm mouse` \
		`use_enable ipv6` \
		`use_enable ssl digest-auth` \
		`use_with ssl` \
		${myconf} || die

	emake package=w3m-m17n \
		W3M=w3m-m17n \
		MAN='env LC_MESSAGES=$${LC_MESSAGES:-$${LC_ALL:-$${LANG}}} LANG=C man'\
		|| die "make failed"
}

src_install() {

	make package=w3m-m17n DESTDIR=${D} install || die

	# w3mman and manpages conflict with those from w3m
	mv ${D}/usr/bin/w3mman{,-m17n}
	mv ${D}/usr/share/man/man1/w3mman{,-m17n}.1
	#mv ${D}/usr/share/man/man1/w3m{,-m17n}.1
	#mv ${D}/usr/share/man/ja/man1/w3m{,-m17n}.1

	if ! has_version 'net-www/w3m' ; then
		dosym /usr/bin/w3m{-m17n,}
		dosym /usr/bin/w3mman{-m17n,}
		dosym /usr/share/man/ja/man1/w3m{-m17n,}.1
		dosym /usr/share/man/man1/w3m{-m17n,}.1
		dosym /usr/share/man/man1/w3mman{-m17n,}.1
	fi

	insinto /usr/share/${PN}/Bonus
	doins Bonus/*
	dodoc README NEWS TODO ChangeLog
	docinto doc-en ; dodoc doc/*
	docinto doc-jp ; dodoc doc-jp/*
}
