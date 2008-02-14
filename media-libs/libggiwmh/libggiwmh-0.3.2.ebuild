# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libggiwmh/libggiwmh-0.3.2.ebuild,v 1.8 2008/02/14 21:43:01 fmccor Exp $

DESCRIPTION="Library for General Graphics Interface"
HOMEPAGE="http://www.ggi-project.org"
SRC_URI="mirror://sourceforge/ggi/${P}.src.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc64 sparc x86 ~x86-fbsd"
IUSE="X"

RDEPEND=">=media-libs/libggi-2.2.2
	X? ( x11-libs/libXxf86vm
		x11-libs/libXxf86dga
		x11-libs/libXext
		x11-libs/libX11 )"
DEPEND="${RDEPEND}"

src_compile() {
	econf $(use_enable X x) $(use_with X x)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog README doc/*.txt
}
