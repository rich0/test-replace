# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/metacity/metacity-2.4.0.ebuild,v 1.2 2002/08/12 11:06:27 azarah Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Small gtk2 WindowManager"
SRC_URI="http://people.redhat.com/~hp/metacity/${P}.tar.gz"
HOMEPAGE="http://people.redhat.com/~hp/metacity/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/pango-1.0.2
	>=x11-libs/gtk+-2.0.5
	>=gnome-base/gconf-1.1.11
	>=net-libs/linc-0.1.20
	>=gnome-base/ORBit2-2.4.0
	>=gnome-base/libglade-2.0.0"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} --enable-platform-gnome-2"
DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README"

