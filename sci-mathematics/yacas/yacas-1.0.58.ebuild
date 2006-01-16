# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/yacas/yacas-1.0.58.ebuild,v 1.2 2006/01/16 01:27:57 cryos Exp $

inherit eutils

IUSE="glut"

DESCRIPTION="very powerful general purpose Computer Algebra System"
HOMEPAGE="http://yacas.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/backups/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~x86"

DEPEND="virtual/libc
	>=sys-apps/sed-4
	glut? ( media-libs/glut )
	www-client/lynx"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if ! use glut; then
		sed -e 's:opengl::g' -i plugins/Makefile.in || die "sed (opengl) failed"
		sed -e 's/\(^PLUGINDOCSCHAPTERS.*\)opengl.chapt\(.*\)/\1 \2/' -i \
		manmake/Makefile.in || die 'sed (manmake) failed'
	fi
}

src_compile() {
	econf --with-numlib=native || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR="${D}" install-strip || die

	dodoc AUTHORS INSTALL NEWS README TODO
	mv "${D}"/usr/share/${PN}/documentation "${D}"/usr/share/doc/${PF}/html
	rmdir "${D}"/usr/include/
	rm "${D}"/usr/share/${PN}/include/win32*
	sed -e "s|\":FindFile(\"documentation/ref.html\"):\"|localhost/usr/share/doc/${PF}/html/ref.html|" \
		-e "s|\":FindFile(\"documentation/books.html\"):\"|localhost/usr/share/doc/${PF}/html/books.html|" \
		-i "${D}"/usr/share/${PN}/yacasinit.ys || die
}
