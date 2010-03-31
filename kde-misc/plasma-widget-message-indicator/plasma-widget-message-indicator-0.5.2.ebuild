# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/plasma-widget-message-indicator/plasma-widget-message-indicator-0.5.2.ebuild,v 1.2 2010/03/31 19:52:12 tampakrap Exp $

EAPI=2

inherit kde4-base

DESCRIPTION="Plasmoid for displaying Ayatana indications"
HOMEPAGE="https://launchpad.net/plasma-widget-message-indicator"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	!kde-misc/plasma-indicatordisplay
	>=dev-libs/libindicate-qt-0.2.5
	>=dev-libs/libdbusmenu-qt-0.3.0
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
"
