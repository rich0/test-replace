# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/eggdrop/eggdrop-1.6.15-r2.ebuild,v 1.8 2004/06/24 23:03:55 agriffis Exp $

inherit fixheadtails eutils

DESCRIPTION="An IRC bot extensible with C or Tcl."
HOMEPAGE="http://www.eggheads.org/"
SRC_URI="ftp://ftp.eggheads.org/pub/eggdrop/source/1.6/eggdrop${PV}.tar.gz
http://gentoo.mirror.at.stealer.net/files/${P}-STEALER.net.patch.bz2
		http://www.egghelp.org/files/patches/eggdrop${PV}-ssl.fixed.diff.gz"
KEYWORDS="~x86 ~sparc ~mips ~ia64 ~amd64 ~ppc"

LICENSE="GPL-2"
SLOT="0"

IUSE="debug static ipv6 ssl mysql"
DEPEND="dev-lang/tcl
	ssl? ( dev-libs/openssl )
	mysql? ( dev-db/mysql )"

pkg_setup() {
	use ipv6 && \
		ewarn "Note: If eggdrop is built with ipv6 support, the dns.so module is"
		ewarn "not built."

	use mysql && \
		ewarn "Note: for this release mysql has been temporarily disabled."
}

src_unpack()  {

	unpack ${A}
	use ssl && epatch eggdrop${PV}-ssl.fixed.diff

	mv ${WORKDIR}/eggdrop${PV} ${WORKDIR}/${P}

	epatch ${FILESDIR}/${P}-config.patch
	epatch ${FILESDIR}/${P}-botchk.patch
	epatch ${FILESDIR}/${P}-configure-in.patch
	epatch ${FILESDIR}/${P}-potential-undef-tm-struct.patch
	epatch ${P}-STEALER.net.patch
	epatch ${FILESDIR}/${P}-mysql-use_ssl-fix.patch

	cd ${WORKDIR}/${P}
	ht_fix_file configure aclocal.m4

	autoconf || die "autoconf failed?!"

}

src_compile() {
	local mytarg myconf

	# Sets eggdrop to use ipv6
	use ipv6 && myconf="${myconf} --enable-ipv6"
	use mysql || echo mysql >>disabled_modules
	use ssl && myconf="${myconf} --with-ssl"
	./configure \
		--host=${CHOST} \
		--disable-cc-optimization \
		${myconf} || die "./configure failed"

	make config || die "module config failed"

	if use static; then
		make static || die "make static failed"
	fi

	if use debug; then
		make debug || die "make debug failed"
	fi
	make || die "make failed"

}

src_install() {

	local a
	make DEST=${D}/opt/eggdrop install

	for a in doc/*
	do
		[ -f $a ] && dodoc $a
	done

	cd src/mod
	for a in *.mod
	do
		for b in README UPDATES INSTALL TODO CONTENTS
		do
			[ -f $a/$b ] && newdoc $a/$b $b.$a
		done
	done
	cd ${S}

	dodoc src/mod/botnetop.mod/botnetop.conf src/mod/gseen.mod/gseen.conf
	dodoc src/mod/mc_greet.mod/mc_greet.conf src/mod/stats.mod/stats.conf
	dodoc src/mod/away.mod/away.doc src/mod/rcon.mod/matchbot.tcl

	for a in doc/html/*
	do
		[ -f $a ] && dohtml $a
	done

	dobin ${FILESDIR}/eggdrop-installer
	doman doc/man1/eggdrop.1
}

pkg_postinst() {
	einfo "Please run /usr/bin/eggdrop-installer to install your eggdrop bot."

	if use ssl; then
		einfo "You must ad 'set use-ssl [0/1]' to your bot.conf to disable/"
		einfo "enable SSL connectivity."
	fi
}
