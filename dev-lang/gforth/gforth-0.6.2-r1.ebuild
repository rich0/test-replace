# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gforth/gforth-0.6.2-r1.ebuild,v 1.1 2006/02/15 00:12:42 mkennedy Exp $

inherit elisp-common eutils toolchain-funcs

DESCRIPTION="GNU Forth is a fast and portable implementation of the ANSI Forth language"
HOMEPAGE="http://www.gnu.org/software/gforth"
SRC_URI="http://www.complang.tuwien.ac.at/forth/gforth/${P}.tar.gz
	http://www.complang.tuwien.ac.at/forth/gforth/Patches/${PV}-debug.diff"

LICENSE="GPL-2"
SLOT="0"
# KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
KEYWORDS=" ~ppc ~x86"			# dev-libs/ffcall needs to be keyworded for amd64 and ppc-macos
IUSE="emacs"

DEPEND="virtual/libc
	dev-libs/ffcall
	emacs? ( virtual/emacs )"

SITEFILE=50gforth-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gforth.el-gentoo.patch || die
	epatch ${FILESDIR}/${PV}-c-to-forth-to-c.patch || die
	epatch ${DISTDIR}/${PV}-debug.diff || die

}

src_compile() {
	econf CC="$(tc-getCC) -fno-reorder-blocks -fno-inline" --enable-force-reg || die "econf failed"
	make || die
	if use emacs; then
		elisp-comp *.el || die
	fi
}

src_install() {
	make \
		libdir=${D}/usr/lib \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		datadir=${D}/usr/share \
		bindir=${D}/usr/bin \
		install || die

	dodoc AUTHORS BUGS ChangeLog NEWS* README* ToDo doc/glossaries.doc doc/*.ps

	if use emacs; then
		elisp-install ${PN} *.el *.elc
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
