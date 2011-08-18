# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgweather/libgweather-3.0.2.ebuild,v 1.1 2011/08/18 07:38:21 nirbheek Exp $

EAPI="3"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Library to access weather information from online services"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
IUSE="+introspection doc"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"

# libsoup-gnome is to be used because libsoup[gnome] might not
# get libsoup-gnome installed by the time ${P} is built
COMMON_DEPEND=">=x11-libs/gtk+-2.90.0:3[introspection?]
	>=dev-libs/glib-2.13
	>=gnome-base/gconf-2.8
	>=net-libs/libsoup-gnome-2.25.1:2.4
	>=dev-libs/libxml2-2.6.0
	>=sys-libs/timezone-data-2010k

	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40.3
	>=dev-util/pkgconfig-0.19
	>=dev-util/gtk-doc-am-1.9
	sys-devel/gettext
	doc? ( >=dev-util/gtk-doc-1.9 )"
RDEPEND="${COMMON_DEPEND}
	!<gnome-base/gnome-applets-2.22.0"

pkg_setup() {
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS"
	# Do not add --disable-all-translations-in-one-xml : it will enable them
	G2CONF="${G2CONF}
		--enable-locations-compression
		--disable-maintainer-mode
		--disable-static
		$(use_enable introspection)"
}
