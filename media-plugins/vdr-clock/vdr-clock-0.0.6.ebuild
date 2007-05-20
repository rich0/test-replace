# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-clock/vdr-clock-0.0.6.ebuild,v 1.1 2007/05/20 14:13:54 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Clock PlugIn"
HOMEPAGE="http://vdr.humpen.at"
SRC_URI="http://vdr.humpen.at/uploads/media/${P}.tgz
		mirror://vdrfiles/${PN}/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.2.0"

PATCHES="${FILESDIR}/${PV}/pingpong-fixes.diff"

