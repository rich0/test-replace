# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-decruft/vdr-decruft-0.0.4-r1.ebuild,v 1.2 2009/05/07 19:42:09 hd_brummy Exp $

IUSE=""
inherit vdr-plugin eutils

DESCRIPTION="Video Disk Recorder DeCruft Plugin - Clean unwanted entries from channels.conf"
HOMEPAGE="http://www.rst38.org.uk/vdr/decruft/"
SRC_URI="http://www.rst38.org.uk/vdr/decruft/${P}.tgz"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.21-r2"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${P}-avoid-vdr-patch.diff")

src_install() {
	vdr-plugin_src_install
	insinto /etc/vdr/plugins
	doins examples/decruft.conf
}
