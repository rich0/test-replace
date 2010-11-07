# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/plasma-widget-message-indicator/plasma-widget-message-indicator-0.5.5.ebuild,v 1.1 2010/11/07 17:37:21 dilfridge Exp $

EAPI=2

inherit kde4-base

DESCRIPTION="Plasmoid for displaying Ayatana indications"
HOMEPAGE="https://launchpad.net/plasma-widget-message-indicator"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	>=dev-libs/libdbusmenu-qt-0.3.0
	>=dev-libs/libindicate-qt-0.2.5
"
RDEPEND="${DEPEND}
	!kde-misc/plasma-indicatordisplay
"
