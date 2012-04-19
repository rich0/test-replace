# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krossjava/krossjava-4.8.1.ebuild,v 1.3 2012/04/19 04:24:25 maekke Exp $

EAPI=4

KMNAME="kross-interpreters"
KMMODULE="java"
KDE_SCM="git"
inherit java-pkg-2 java-ant-2 kde4-meta eutils

DESCRIPTION="Java plugin for the kdelibs/kross scripting framework."
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=virtual/jdk-1.5
"
RDEPEND="
	>=virtual/jre-1.5
"

RESTRICT="test"

pkg_setup() {
	kde4-meta_pkg_setup
	java-pkg-2_pkg_setup
}

src_prepare() {
	find "${S}" -iname '*.jar' | xargs rm -v
	kde4-meta_src_prepare
	java-pkg-2_src_prepare
}

src_configure() {
	kde4-meta_src_configure
	java-ant-2_src_configure
}

src_compile() {
	kde4-meta_src_compile
	cd "${S}/java/${PN}/java/" || die
	eant makejar
}

src_install() {
	kde4-meta_src_install
	java-pkg_dojar "${ED}/usr/$(get_libdir)/kde4/kross/kross.jar"

	dosym ../../../share/${PN}-${SLOT}/lib/kross.jar \
		/usr/$(get_libdir)/kde4/kross/kross.jar
	java-pkg_regso "${ED}/usr/$(get_libdir)/kde4/krossjava.so"
}

pkg_preinst() {
	kde4-meta_pkg_preinst
	java-pkg-2_pkg_preinst
}
