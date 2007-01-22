# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkmm/gtkmm-2.2.12.ebuild,v 1.14 2007/01/22 12:31:01 kloeri Exp $

inherit gnome2

DESCRIPTION="C++ interface for GTK+2"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	=dev-libs/libsigc++-1.2*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!=sys-devel/gcc-3.3.0*"

DOCS="AUTHORS CHANGES ChangeLog HACKING PORTING NEWS README TODO"
