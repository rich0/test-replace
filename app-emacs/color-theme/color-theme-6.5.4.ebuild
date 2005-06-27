# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/color-theme/color-theme-6.5.4.ebuild,v 1.10 2005/06/27 04:21:03 mkennedy Exp $

inherit elisp eutils

IUSE=""

DESCRIPTION="Install color themes (includes many themes and allows you to share your own with the world)"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?ColorTheme"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 sparc"

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-easy-menu-gentoo.patch
}
