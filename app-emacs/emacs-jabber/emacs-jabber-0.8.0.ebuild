# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-jabber/emacs-jabber-0.8.0.ebuild,v 1.3 2009/10/11 19:42:03 nixnut Exp $

inherit elisp

DESCRIPTION="A Jabber client for Emacs"
HOMEPAGE="http://emacs-jabber.sourceforge.net/
	http://emacswiki.org/cgi-bin/wiki/JabberEl"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/gnus-5.10"
RDEPEND="${DEPEND}"

DOCS="AUTHORS NEWS README"
SITEFILE="70${PN}-gentoo.el"

src_compile() {
	elisp_src_compile
	makeinfo jabber.texi || die
}

src_install() {
	elisp_src_install
	doinfo jabber.info || die
}

pkg_postinst() {
	elisp_pkg_postinst
	elog "If you want to use SASL authentication, you need either Emacs 23,"
	elog "or install one of virtual/flim or app-emacs/ngnus."
}
