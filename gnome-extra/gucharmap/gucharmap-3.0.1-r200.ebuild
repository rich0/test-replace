# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gucharmap/gucharmap-3.0.1-r200.ebuild,v 1.3 2012/04/18 21:20:53 ago Exp $

EAPI="3"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Unicode character map viewer library"
HOMEPAGE="http://live.gnome.org/Gucharmap"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="cjk doc +introspection"

RDEPEND=">=dev-libs/glib-2.16.3
	>=x11-libs/pango-1.2.1[introspection?]
	>=x11-libs/gtk+-2.14.0:2[introspection?]

	introspection? ( >=dev-libs/gobject-introspection-0.9.0 )"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.40

	sys-devel/gettext

	doc? ( >=dev-util/gtk-doc-1.0 )"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		--disable-scrollkeeper
		--disable-maintainer-mode
		--with-gtk=2.0
		--disable-charmap
		--disable-gconf
		$(use_enable introspection)
		$(use_enable cjk unihan)"
	# gconf is only needed for the gucharmap program
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	# .desktop and schema files are only needed for the gucharmap program
	sed -e 's:desktop_DATA\s*=.*:desktop_DATA = :' \
		-e 's:schema_DATA\s*=.*:schema_DATA = :' \
		-i Makefile.* || die "sed Makefile.* failed"

	gnome2_src_prepare
}

pkg_postinst() {
	gnome2_pkg_postinst
	if ! has_version "gnome-extra/gucharmap:2.90" ; then
		ewarn "Note: ${PF} includes only the gucharmap-2 library."
		ewarn "If you need the gucharmap program, emerge gucharmap:2.90"
	fi
}
