# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgtop/libgtop-2.6.0.ebuild,v 1.12 2005/01/09 11:14:17 slarti Exp $

inherit gnome2

DESCRIPTION="A library that provides top functionality to applications"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"

IUSE=""
SLOT="2"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ~ia64 mips ppc64"

RDEPEND=">=dev-libs/glib-2
	dev-libs/popt"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README RELNOTES*"

USE_DESTDIR="1"
