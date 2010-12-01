# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-anthy/ibus-anthy-1.2.5.ebuild,v 1.1 2010/12/01 16:42:24 matsuu Exp $

EAPI=2
PYTHON_DEPEND="2:2.5"
inherit eutils python

DESCRIPTION="Japanese input method Anthy IMEngine for IBus Framework"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND=">=app-i18n/ibus-1.2.0.20100111
	app-i18n/anthy
	>=dev-python/pygtk-2.15.2
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-lang/swig
	dev-util/pkgconfig
	nls? ( >=sys-devel/gettext-0.16.1 )"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
	sed -i -e "s/python/python2/" \
		engine/ibus-engine-anthy.in setup/ibus-setup-anthy.in || die
}

src_configure() {
	econf $(use_enable nls) || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README || die
}

pkg_postinst() {
	elog
	elog "app-dicts/kasumi is not required but probably useful for you."
	elog
	elog "# emerge app-dicts/kasumi"
	elog

	python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
