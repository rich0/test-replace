# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmowgli/libmowgli-0.1.3.ebuild,v 1.4 2007/04/02 11:04:57 armin76 Exp $

DESCRIPTION="High-performance C development framework. Can be used stand-alone or as a supplement to GLib."
HOMEPAGE="http://sacredspiral.co.uk/~nenolod/mowgli/"
SRC_URI="http://sidhe.atheme.org/~nenolod/mowgli/${P}.tgz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README TODO
}
