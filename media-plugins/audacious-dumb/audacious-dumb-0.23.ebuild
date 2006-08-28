# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/audacious-dumb/audacious-dumb-0.23.ebuild,v 1.3 2006/08/28 21:08:58 vapier Exp $

DESCRIPTION="Audacious Plug-in for accurate, high-quality IT/XM/S3M/MOD playback"
HOMEPAGE="http://www.netswarm.net/"
SRC_URI="http://www.netswarm.net/misc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-sound/audacious-1.1
	>=media-libs/dumb-0.9.3"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog README README-dumb-bmp README-dumb-xmms
}
