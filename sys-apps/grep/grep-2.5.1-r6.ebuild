# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.5.1-r6.ebuild,v 1.7 2004/09/30 09:51:46 kloeri Exp $

inherit gnuconfig flag-o-matic eutils

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="http://www.gnu.org/software/grep/grep.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc mips alpha arm hppa amd64 ia64 ~ppc64 ~s390"
IUSE="build nls pcre static uclibc"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	pcre? (
		>=sys-apps/sed-4
		dev-libs/libpcre )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A} && cd ${S} || die

	if [ "${ARCH}" = "sparc" -a "${PROFILE_ARCH}" = "sparc" ] ; then
		epatch "${FILESDIR}/gentoo-sparc32-dfa.patch"
	fi
	epatch "${FILESDIR}/${PV}-manpage.patch"

	# man page describes a --line-buffering option, where as
	# grep recognises --line-buffered.
	# 	-taviso (20 Aug 2004)
	epatch ${FILESDIR}/${PV}-manpage-line-buffering.diff

	use uclibc && epatch ${FILESDIR}/grep-2.5.1-restrict_arr.patch

	epatch ${FILESDIR}/${PN}-${PV}-fgrep.patch.bz2
	epatch ${FILESDIR}/${PN}-${PV}-i18n.patch.bz2
	epatch ${FILESDIR}/${PN}-${PV}-gofast.patch.bz2
	epatch ${FILESDIR}/${PN}-${PV}-oi.patch.bz2

	# Fix configure scripts to detect linux-mips
	gnuconfig_update
}

src_compile() {
	local myconf="
		$(use_enable nls)
		--bindir=/bin"

	if use static ; then
		append-flags -static
		append-ldflags -static
	fi

	if use uclibc ; then
		myconf="${myconf} --without-included-regex"
	else
		myconf="${myconf} $(use_enable pcre perl-regexp)"
	fi

	econf ${myconf} || die "econf failed"

	if use pcre && ! use uclibc ; then
		sed -i -e 's:-lpcre:/usr/lib/libpcre.a:g' {lib,src}/Makefile \
			|| die "sed Makefile failed"
	fi

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# Override the default shell scripts... grep knows how to act
	# based on how it's called
	ln -sfn grep "${D}/bin/egrep" || die "ln egrep failed"
	ln -sfn grep "${D}/bin/fgrep" || die "ln fgrep failed"

	if use build ; then
		rm -rf "${D}/usr/share"
	else
		dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	fi
}
