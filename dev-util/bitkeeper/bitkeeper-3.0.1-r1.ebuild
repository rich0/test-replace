# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bitkeeper/bitkeeper-3.0.1-r1.ebuild,v 1.1 2003/03/31 17:03:36 mholzer Exp $

DESCRIPTION="A scalable configuration management system."
HOMEPAGE="http://www.bitkeeper.com/"
SRC_URI="x86? ( bk-3.0.1-x86-glibc22-linux.bin )
	ppc? ( bk-3.0.1-powerpc-glibc21-linux.bin )
	sparc? ( bk-3.0.1-sparc-glibc21-linux.bin )
	alpha? ( bk-3.0.1-alpha-glibc21-linux.bin )
	arm? ( bk-3.0.1-arm-glibc21-linux.bin )
	hppa? ( bk-3.0.1-hppa-glibc22-linux.bin )"

SLOT="0"
LICENSE="BKL"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~hppa"
IUSE="X"

# binary package, so no DEPENDs; X optional in RDEPENDs
DEPEND=""
RDEPEND="x86? ( >=virtual/glibc-2.2 )
	ppc? ( >=virtual/glibc-2.1 )
	sparc? ( >=virtual/glibc-2.1 )
	alpha? ( >=virtual/glibc-2.1 )
	arm? ( >=virtual/glibc-2.1 )
	hppa? ( >=virtual/glibc-2.2 )
	>=dev-lang/tcl-8.3.3
	X? ( >=dev-lang/tk-8.3.3 )"

RESTRICT="fetch"

S=${WORKDIR}/bitkeeper

pkg_nofetch() {
	eerror "You need to perform the following steps to install this package:"
	eerror " - Sign up at ${HOMEPAGE}"
	eerror " - Check your email and visit the download location"
	eerror " - Download ${A} and place it in ${DISTDIR}"
	eerror " - emerge this package again"
	eerror "Run 'bk regression' to verify the installation. (Recommended)"
}

pkg_setup() {
	cd ${T}
	cp ${DISTDIR}/${A} .
	chmod 755 ${A}
	echo 'none' | ./${A} > output 2>/dev/null
	installer=`sed -n -e "s/Installation script: \(.*\)/\1/p" output`
	archive=`sed -n -e "s/Gzipped tar archive: \(.*\)/\1/p" output`
	mv $archive ${T}/archive
}

src_unpack() {
	tar -vxzpf ${T}/archive
	chown -R root:root ${S}
	chmod -R u+w,go-w ${S}
}

src_install() {
	dodir /opt /etc/env.d /usr/share/man/man1

	mv ${S} ${D}/opt/${P} && cd ${D}

	# BK includes two copies of most man pages; the second copy is a
	# hard link to the first with its filename prefixed with
	# 'bk-'. 'prepman' breaks these hard links, so use a
	# workaround. Furthermore, we want only the 'bk-' versions to be
	# in ${MANPATH} since there are naming conflicts, so install
	# symlinks into /usr/share/man. (For example BK includes a
	# less-detailed man page for grep which would override the
	# /usr/share/man version.)

	prepman /opt/${P}

	find opt/${P}/man -iname 'bk-*' -printf '
		F=`echo %f|sed -e "s/bk-//"`
		rm -f %h/$F
		dohard /%h/%f /%h/$F
		dosym /%h/%f /usr/share/man/%P' >${T}/links.sh
	. ${T}/links.sh

	dosym /opt/${P}/man/man1/bk.1.gz /usr/share/man/man1/bk.1.gz

	cat <<-EOF >${D}/etc/env.d/10bitkeeper
		# Generated by ${PF} ebuild
		PATH=/opt/${P}
		ROOTPATH=/opt/${P}
		EOF
}

pkg_postinst() {
	einfo "Run 'bk regression' to verify the installation. (Recommended)"
}
