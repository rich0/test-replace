# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fluxconf/fluxconf-0.9.9.ebuild,v 1.1 2007/07/20 12:00:00 drac Exp $

DESCRIPTION="Configuration editor for fluxbox"
SRC_URI="http://devaux.fabien.free.fr/flux/${P}.tar.gz"
HOMEPAGE="http://devaux.fabien.free.fr/flux/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}"

src_compile() {
	econf $(use_enable nls)
	emake || die "emake failed."
}

src_install () {
	einstall || die "einstall failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
