# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/readline/readline-5.0.ebuild,v 1.3 2004/08/24 04:36:42 swegener Exp $

inherit eutils gnuconfig

# Official patches
PLEVEL=""

DESCRIPTION="Another cute console display library"
HOMEPAGE="http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html"
SRC_URI="mirror://gnu/readline/${P}.tar.gz
	${PLEVEL//x/mirror://gnu/${PN}/${PN}-${PV}-patches/${PN}${PV/\.}-}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390"
IUSE=""

# We must be certain that we have a bash that is linked
# to its internal readline, else we may get problems.
DEPEND=">=app-shells/bash-2.05b-r2
	>=sys-libs/ncurses-5.2-r2"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	for x in ${PLEVEL//x}
	do
		epatch ${DISTDIR}/${PN}${PV/\.}-${x}
	done

	gnuconfig_update
}

pkg_setup() {
	# this adds support for installing to lib64/lib32. since only portage
	# 2.0.51 will have this functionality supported in dolib and friends,
	# and since it isnt expected that many profiles will define it, we need
	# to make this variable default to lib.
	[ -z "${CONF_LIBDIR}" ] && export CONF_LIBDIR="lib"
}

src_compile() {
	econf --with-curses || die
	emake || die
}

src_install() {
	einstall || die
	dodir /${CONF_LIBDIR}
	mv ${D}/usr/${CONF_LIBDIR}/*.so* ${D}/${CONF_LIBDIR}

	# Bug #4411
	gen_usr_ldscript libreadline.so
	gen_usr_ldscript libhistory.so

	dodoc CHANGELOG CHANGES README USAGE NEWS
	docinto ps
	dodoc doc/*.ps
	dohtml -r doc

	# Backwards compatibility #29865
	if [ -e ${ROOT}/lib/libreadline.so.4 ] ; then
		cp -a ${ROOT}/lib/libreadline.so.4* ${D}/lib/
		touch ${D}/lib/libreadline.so.4*
	fi
}

pkg_postinst() {
	if [ -e ${ROOT}/lib/libreadline.so.4 ] ; then
		ewarn "Your old readline libraries have been copied over."
		ewarn "You should run 'revdep-rebuild --soname libreadline.so.4' asap."
		ewarn "Once you have, you can safely delete /lib/libreadline.so.4*"
	fi
}
