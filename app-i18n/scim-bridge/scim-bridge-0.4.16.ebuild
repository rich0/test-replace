# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-bridge/scim-bridge-0.4.16.ebuild,v 1.3 2009/08/15 13:20:59 betelgeuse Exp $

EAPI="2"

inherit autotools eutils qt3

DESCRIPTION="Yet another IM-client of SCIM"
HOMEPAGE="http://www.scim-im.org/projects/scim_bridge"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc64 ~sparc ~x86"
IUSE="doc gtk qt3 qt4"

RESTRICT="test"

RDEPEND=">=app-i18n/scim-1.4.6
	gtk? (
		>=x11-libs/gtk+-2.2
		>=x11-libs/pango-1.1
	)
	qt3? (
		|| (
			x11-libs/qt:3[immqt-bc]
			x11-libs/qt:3[immqt]
		)
		>=x11-libs/pango-1.1
	)
	qt4? (
		|| ( ( x11-libs/qt-gui:4 x11-libs/qt-core:4 )
			=x11-libs/qt-4.3*:4 )
		>=x11-libs/pango-1.1
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	doc? ( app-doc/doxygen )"

get_gtk_confdir() {
	if use amd64 || ( [ "${CONF_LIBDIR}" == "lib32" ] && use x86 ) ; then
		echo "/etc/gtk-2.0/${CHOST}"
	else
		echo "/etc/gtk-2.0"
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.4.15.2-qt4.patch"
	epatch "${FILESDIR}/${PN}-0.4.15.2-gcc43.patch"
	epatch "${FILESDIR}/${P}+gcc-4.4.patch"

	# bug #241954
	intltoolize --force
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable gtk gtk2-immodule) \
		$(use_enable qt3 qt3-immodule) \
		$(use_enable qt4 qt4-immodule) \
		$(use_enable doc documents) || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README || die
}

pkg_postinst() {
	elog
	elog "If you would like to use ${PN} as default instead of scim, set"
	elog " $ export GTK_IM_MODULE=scim-bridge"
	elog " $ export QT_IM_MODULE=scim-bridge"
	elog
	[ -x /usr/bin/gtk-query-immodules-2.0 ] && gtk-query-immodules-2.0 > "${ROOT}$(get_gtk_confdir)/gtk.immodules"
}

pkg_postrm() {
	[ -x /usr/bin/gtk-query-immodules-2.0 ] && gtk-query-immodules-2.0 > "${ROOT}$(get_gtk_confdir)/gtk.immodules"
}
