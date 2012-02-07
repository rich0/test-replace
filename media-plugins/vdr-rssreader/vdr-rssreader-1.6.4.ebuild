# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-rssreader/vdr-rssreader-1.6.4.ebuild,v 1.3 2012/02/07 00:26:02 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR Plugin: RSS feed reader"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/rssreader/"
SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/rssreader/files/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0
		>=dev-libs/expat-1.95.8
		>=net-misc/curl-7.15.1-r1"

RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-gentoo-rss.diff"
	"${FILESDIR}/${P}-curl-headers.patch" )

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/rssreader
	doins "${S}/rssreader/rssreader.conf"
}
