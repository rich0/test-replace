# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/johntheripper/johntheripper-1.6.37.ebuild,v 1.1 2004/05/22 01:42:12 dragonheart Exp $

inherit eutils flag-o-matic

MY_P=${P/theripper/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/john/"
SRC_URI="http://www.openwall.com/john/b/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}-gentoo.patch"

#
# john-{$PV}-gentoo.patch is a heavly hacked combination of:
#        mirror://debian/pool/main/j/john/${DEBPATCH}.gz
#        ftp://ftp.openwall.com/pub/projects/john/contrib/john-ntlm-patch-v02.tgz
#        http://www.monkey.org/~dugsong/john-1.6.krb4.patch-3
#        http://www.monkey.org/~dugsong/john-1.6.skey.patch-1
#        ftp://ftp.openwall.com/pub/projects/john/contrib/john-1.6-mysql-1.diff
#        ftp://ftp.openwall.com/pub/projects/john/contrib/john-1.6.31-eggpatch-8.diff.gz
#

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~mips ~hppa"
IUSE="mmx ntlm skey mysql"

# use debug && RESTRICT="${RESTRICT} nostrip"

RDEPEND="virtual/glibc
	skey? ( app-admin/skey )
	kerberos? ( dev-libs/openssl )"

DEPEND="${RDEPEND}
	sys-devel/binutils
	sys-devel/gcc"

src_unpack() {
	unpack ${A}
	epatch ${DISTDIR}/${MY_P}-gentoo.patch
}

src_compile() {
	cd src
	sed -i -e "s:-march=i486::" -e "s:-Wall -O2:${CFLAGS}:" \
		Makefile
	local OPTIONS="EGG=true"
	use kerberos && OPTIONS="${OPTIONS} KERBEROS=true"
	use ntlm && OPTIONS="${OPTIONS} NTLM=true"
	use skey && OPTIONS="${OPTIONS} SKEY=true"
	use mysql && OPTIONS="${OPTIONS} MYSQL=true"

	if use x86 ; then
		local K6=is-flag "-march=k6-3" || is-flag "-march=k6-2" || is-flag "-march=k6"
		if use mmx ; then
			emake ${OPTIONS} linux-x86-mmx-elf || die "Make failed"
		elif ${K6} ; then
			emake ${OPTIONS} linux-x86-k6-elf || die "Make failed"
		else
			emake ${OPTIONS} generic || die "Make failed"
		fi
	elif use alpha ; then
		emake ${OPTIONS} linux-alpha || die "Make failed"
	elif use sparc; then
		emake ${OPTIONS} linux-sparc  || die "Make failed"
	elif use ppc; then
		emake ${OPTIONS} linux-ppc  || die "Make failed"
	elif use amd64; then
		if use mmx; then
			emake ${OPTIONS} linux-x86-64-mmx  || die "Make failed"
		else
			emake ${OPTIONS} linux-x86-64  || die "Make failed"
		fi
	else
		emake ${OPTIONS} generic || die "Make failed"
	fi

	#use debug && emake bench

}

src_install() {
	insinto /etc
	doins run/john.ini debian/john-mail.msg debian/john-mail.conf
	insinto /usr/share/${PN/theripper/}
	doins run/password.lst \
		debian/john-dailyscript
	doman debian/*.1
	dosbin run/john debian/mailer debian/john-cronjob

	dosym john /usr/sbin/unafs
	dosym john /usr/sbin/unique
	dosym john /usr/sbin/unshadow

	# for EGG only
	dosym john /usr/sbin/undrop

	# use debug && dobin src/bench

	dodoc debian/{CONFIG.mailer,copyright} doc/*
}
