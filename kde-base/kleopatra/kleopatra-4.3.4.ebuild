# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kleopatra/kleopatra-4.3.4.ebuild,v 1.3 2010/01/23 20:22:49 abcd Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Kleopatra - KDE X.509 key manager"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	app-crypt/gpgme
	dev-libs/libassuan
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep libkleo)
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
"

KMEXTRACTONLY="
	libkleo
"
KMLOADLIBS="libkleo"

src_unpack() {
	if use handbook; then
		KMEXTRA="
			doc/kwatchgnupg
		"
	fi

	kde4-meta_src_unpack
}

src_configure() {
	mycmakeargs=(
		-DWITH_QGPGME=ON
	)

	kde4-meta_src_configure
}
