# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-zaphistory/vdr-zaphistory-0.9.4-r1.ebuild,v 1.1 2006/05/17 20:18:08 zzam Exp $

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="vdr Plugin: Shows the least recently used channels"
HOMEPAGE="http://vaasa.wi-bw.tfh-wildau.de/~pjuszack/digicam/#zaphistory"
SRC_URI="http://vaasa.wi-bw.tfh-wildau.de/~pjuszack/digicam/download/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="~x86"

DEPEND=">=media-video/vdr-1.3.34"

PATCHES="${FILESDIR}/${P}-fix-crash-no-info.diff"

