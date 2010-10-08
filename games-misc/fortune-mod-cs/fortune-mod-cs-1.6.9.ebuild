# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-cs/fortune-mod-cs-1.6.9.ebuild,v 1.9 2010/10/08 02:53:23 leio Exp $

DESCRIPTION="Database of the Czech and Slovak cookies for the fortune(6) program"
HOMEPAGE="http://ftp.fi.muni.cz/pub/linux/people/zdenek_pytela/"
SRC_URI="http://ftp.fi.muni.cz/pub/linux/people/zdenek_pytela/${P/-mod/}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="unicode"

RDEPEND="games-misc/fortune-mod"
DEPEND="${RDEPEND}
	unicode? ( virtual/libiconv )"

S=${WORKDIR}/${P/-mod/}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f LICENSE install.sh fortune-cs.* *xpm
}

src_compile() {
	local f
	for f in [[:lower:]]* ; do
		if use unicode ; then
			iconv --from-code iso-8859-2 --to-code utf8 -o${f}.utf8 ${f}
			mv ${f}.utf8 ${f}
		fi
		strfile -s ${f} || die "strfile ${f} failed"
	done
}

src_install() {
	insinto /usr/share/fortune/cs
	doins [[:lower:]]* || die "doins failed"
	dodoc [[:upper:]]*
}
