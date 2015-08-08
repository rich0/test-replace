# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2

DESCRIPTION="Library for embedding a Clutter canvas (stage) in GTK+"
HOMEPAGE="https://wiki.gnome.org/Projects/Clutter"
LICENSE="LGPL-2.1+"

SLOT="1.0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples +introspection"

RDEPEND="
	>=x11-libs/gtk+-3.6.0:3[introspection?]
	>=media-libs/clutter-1.22.2-r1:1.0[introspection?]
	media-libs/cogl:1.0=[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	>=sys-devel/gettext-0.18
	virtual/pkgconfig
"

src_prepare() {
	# patches from upstream git master
	epatch "${FILESDIR}"/${P}-clutter_gdk_get_visual.patch

	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-maintainer-flags \
		--enable-deprecated \
		$(use_enable introspection)
}

src_install() {
	gnome2_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/{*.c,redhand.png}
	fi
}
