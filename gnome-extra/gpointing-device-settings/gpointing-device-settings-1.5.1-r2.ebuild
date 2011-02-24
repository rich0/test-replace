# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gpointing-device-settings/gpointing-device-settings-1.5.1-r2.ebuild,v 1.1 2011/02/24 09:30:11 dev-zero Exp $

EAPI="2"
GCONF_DEBUG="no"
inherit eutils gnome2

DESCRIPTION="A GTK+ based configuration utility for the synaptics driver"
HOMEPAGE="http://live.gnome.org/GPointingDeviceSettings"
SRC_URI="mirror://sourceforge.jp/gsynaptics/45812/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# recent enough x11-base/xorg-server required
RDEPEND=">=dev-libs/glib-2.10
	>=x11-libs/gtk+-2.14.0
	>=gnome-base/gconf-2.24
	>=gnome-base/gnome-settings-daemon-2.28
	>=x11-libs/libXi-1.2
	>=x11-libs/libX11-1.2.0
	!<=x11-base/xorg-server-1.6.0
	!gnome-extra/gsynaptics"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19
	>=dev-util/intltool-0.35.5"

DOCS="MAINTAINERS NEWS TODO"

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-crash.patch" \
		"${FILESDIR}/${P}-plugin.patch" \
		"${FILESDIR}/${P}-reboot.patch" \
		"${FILESDIR}/${P}-gtk22.patch" \
		"${FILESDIR}/${P}-gsd-crash.patch"
	gnome2_src_prepare
}
