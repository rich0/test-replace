# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/fcron/fcron-2.9.5.1.ebuild,v 1.2 2005/03/16 10:51:29 ka0ttic Exp $

inherit eutils flag-o-matic

DESCRIPTION="A command scheduler with extended capabilities over cron and anacron"
HOMEPAGE="http://fcron.free.fr/"
SRC_URI="http://fcron.free.fr/archives/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~mips ~hppa ~amd64"
IUSE="pam doc selinux"

DEPEND="virtual/editor
	doc? ( >=app-text/docbook-dsssl-stylesheets-1.77 )
	selinux? ( sys-libs/libselinux )
	pam? ( >=sys-libs/pam-0.77 )"
RDEPEND="!virtual/cron
	>=sys-process/cronbase-0.2.1-r3
	virtual/mta"
PROVIDE="virtual/cron"

pkg_setup() {
	# bug #65263
	# fcron's ./configure complains if EDITOR is not set to an absolute path,
	# so try to set it to the abs path if it isn't
	if [[ "${EDITOR}" != */* ]] ; then
		einfo "Attempting to deduce absolute path of ${EDITOR}"
		EDITOR=$(which ${EDITOR} 2>/dev/null)
		[[ -x "${EDITOR}" ]] || \
			die "Please set the EDITOR env variable to the path of a valid executable."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.0.0-configure.diff
	# respect LDFLAGS
	sed -i "s:\(@LIBS@\):\$(LDFLAGS) \1:" Makefile.in || die "sed failed"
}

src_compile() {
	local myconf=
	use doc && \
		myconf="--with-dsssl-dir=/usr/share/sgml/stylesheets/dsssl/docbook"

	autoconf || die "autoconf failed"

	# QA security notice fix; see "[gentoo-core] Heads up changes in suid
	# handing with portage >=51_pre21" for more details.
	append-ldflags -Wl,-z,now

	econf \
		$(use_with pam) \
		$(use_with selinux) \
		--with-username=cron \
		--with-groupname=cron \
		--with-piddir=/var/run \
		--with-etcdir=/etc/fcron \
		--with-spooldir=/var/spool/cron \
		--with-fifodir=/var/run \
		--with-sendmail=/usr/sbin/sendmail \
		--with-fcrondyn=yes \
		--with-editor=${EDITOR} \
		${myconf} \
		|| die "Configure problem"

	emake || die "Compile problem"
}

src_install() {
	dodir /var/spool
	diropts -m 0770 -o cron -g cron
	keepdir /var/spool/cron/fcrontabs

	insinto /usr/sbin
	insopts -o root -g root -m0110 ; doins fcron
	insinto /usr/bin
	insopts -o cron -g cron -m6110 ; doins fcrontab fcrondyn
	insopts -o root -g cron -m6110 ; doins fcronsighup
	dosym fcrontab /usr/bin/crontab

	insinto /etc/fcron
	insopts -m 640 -o root -g cron
	doins files/fcron.{allow,deny,conf}
	dosed 's:^\(fcrontabs.*=.*\)$:\1/fcrontabs:' /etc/fcron/fcron.conf \
		|| die "dosed fcron.conf failed"

	newpamd files/fcron.pam fcron
	newpamd files/fcrontab.pam fcrontab

	insinto /etc
	doins ${FILESDIR}/crontab

	newinitd ${FILESDIR}/fcron.rc6 fcron || die "newinitd failed"

	dodoc MANIFEST VERSION doc/txt/*.txt
	newdoc files/fcron.conf fcron.conf.sample
	use doc && dohtml doc/HTML/*.html
	dodoc ${FILESDIR}/crontab

	doman doc/man/*
}

pkg_postinst() {
	einfo "Each user who uses fcron should be added to the cron group"
	einfo "in /etc/group and also be added in /etc/fcron/fcron.allow"
	einfo
	einfo "To activate /etc/cron.{hourly|daily|weekly|montly} please run: "
	einfo "crontab /etc/crontab"
	einfo
	einfo "!!! That will replace root's current crontab !!!"
	einfo

	echo
	einfo "You may wish to read the Gentoo Linux Cron Guide, which can be"
	einfo "found online at:"
	einfo "    http://www.gentoo.org/doc/en/cron-guide.xml"
	echo
}
