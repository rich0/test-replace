# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonobo/libbonobo-2.10.0.ebuild,v 1.10 2005/09/24 04:28:23 vapier Exp $

inherit gnome2

DESCRIPTION="GNOME CORBA framework"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="debug doc static"

RDEPEND=">=dev-libs/glib-2.3.2
	>=gnome-base/orbit-2.9.2
	>=dev-libs/libxml2-2.4.20
	>=dev-libs/popt-1.5
	!gnome-base/bonobo-activation"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

USE_DESTDIR="1"
G2CONF="${G2CONF} $(use_enable static) \
$(use_enable debug bonobo-activation-debug)"
