# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{3_3,3_4} )

inherit autotools-utils gnome2-utils python-r1 eutils

DESCRIPTION="The IBus engine for users of the Cangjie and Quick input methods"
HOMEPAGE="http://cangjians.github.io"
SRC_URI="http://cangjians.github.io/downloads/ibus-cangjie/ibus-cangjie-${PV}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="${PYTHON_DEPS}
	>=app-i18n/ibus-1.4.1
	app-i18n/libcangjie
	dev-python/cangjie[${PYTHON_USEDEP}]
	dev-util/intltool
	sys-devel/gettext"

RDEPEND=">=app-i18n/ibus-1.4.1
	app-i18n/libcangjie
	dev-python/cangjie[${PYTHON_USEDEP}]
	virtual/libintl
	${PYTHON_DEPS}"

src_prepare() {
		epatch "${FILESDIR}/${PN}-gtk-unit-test.patch"
}

src_configure() {
	python_foreach_impl autotools-utils_src_configure
}

src_compile() {
	python_foreach_impl autotools-utils_src_compile
}

src_install() {
	python_foreach_impl autotools-utils_src_install
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}
