# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ultimate/ultimate-2.8.7.ebuild,v 1.11 2005/02/17 02:25:54 swegener Exp $

inherit eutils

MY_P="${P/ultimate-/Ultimate}"
DESCRIPTION="An IRCd server based on DALnet's DreamForge IRCd."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://www.shadow-realm.org/"

KEYWORDS="x86 ~sparc ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE="debug"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${MY_P}"

[ -z "${localhost}" ] && localhost="localhost"

src_unpack() {

	einfo "To change the settings of your Ultimate ircd server please"
	einfo "edit the ${S}/config/ircd.init file."

	einfo "To change the domain name of your server, edit the localhost in"
	einfo "ultimage-${PV}.ebuild. Otherwise it will default to localhost."

	unpack ${A} ; cd ${S}
	cp Makefile.dist Makefile
	sed -i \
		-e "s:XCFLAGS=:XCFLAGS=${CFLAGS}:g" \
		-e "s:IRCDLIBS=:IRCDLIBS=-lcrypt -lresolv:g" \
		-e "s:IRCDDIR=/usr/local/lib/ircd:IRCDDIR=/usr/lib/ircd:g" \
		-e "s:MANDIR=/usr/local/man:MANDIR=/usr/share/man:g" \
		Makefile || die "sed Makefile failed"

	cp ${FILESDIR}/setup.h ${S}/include/setup.h

	# This is supposed to be generated by ./configure
	echo "#define MYOSNAME \"`uname -a`\"" >> ${S}/include/settings.h
	echo "#define DPATH \"/etc/ultimateircd\"" >> ${S}/include/settings.h
	echo "#define SPATH \"${S}/usr/sbin/ircd\"" >> ${S}/include/settings.h
	echo "#define NICKLEN 30" >> ${S}/include/settings.h
	echo "#define LISTEN_SIZE 5" >> ${S}/include/settings.h
	echo "#define MAXSENDQLENGTH 3000000" >> ${S}/include/settings.h
	echo "#define BUFFERPOOL (6 * MAXSENDQLENGTH)" >> ${S}/include/settings.h
	echo "#define MAXCONNECTIONS 1024" >> ${S}/include/settings.h
	echo "#define NICKNAMEHISTORYLENGTH 500" >> ${S}/include/settings.h
	echo "#define CRYPT_OPER_PASSWORD 1" >> ${S}/include/settings.h
	echo "#undef CRYPT_LINK_PASSWORD" >> ${S}/include/settings.h
	echo "#undef UNIXPORT" >> ${S}/include/settings.h
	echo "#define NOSPOOF 1" >> ${S}/include/settings.h
	echo "#define NOSPOOF_SEED01 0x08101979" >> ${S}/include/settings.h
	echo "#define NOSPOOF_SEED02 0x97910180" >> ${S}/include/settings.h
	echo "#define DOMAINNAME \"localhost\"" >> ${S}/include/settings.h
	echo "#define GLIBC2_x" >> ${S}/include/settings.h

	epatch ${FILESDIR}/Ultimate-${PV}-gentoo.patch

	use debug && \
		sed -i \
		-e "s:#undef  DEBUGMODE:#define  DEBUGMODE:g" config.h
}

src_compile() {
	emake || die "Make failed"
}

src_install() {
	newbin src/ircd ultimate-ircd
	newbin ${S}/makeconf ultimate-makeconf

	dodir /etc/ultimateircd
	insinto /etc/ultimateircd
	doins doc/example.conf
	mv ${D}/etc/ultimateircd/example.conf ${D}/etc/ultimateircd/ircd.conf

	doins config/ircd.channels config/ircd.ini config/ircd.klines
	doins config/ircd.quotes

	dodir /etc/ultimateircd/networks
	insinto /etc/ultimateircd/networks
	doins config/networks/*.network

	exeinto /etc/init.d
	newexe ${FILESDIR}/ultimateircd.rc ultimateircd

	exeinto /etc/conf.d
	newexe  ${FILESDIR}/ultimateircd.conf ultimateircd

	dodoc crypt/crypter ircdcron/ircd.cron ircdcron/ircdchk
}
