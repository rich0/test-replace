# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portagemaster/portagemaster-0.2.1-r1.ebuild,v 1.1 2007/04/29 01:49:19 ali_bush Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="A java portage browser and installer"
HOMEPAGE="http://portagemaster.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND=">=virtual/jdk-1.4.1"
RDEPEND=">=virtual/jre-1.4.1"

S=${WORKDIR}/${PN}
EANT_BUILD_TARGET="package"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e 's:<property name="build.compiler" value="jikes"/>:<!--<property name="build.compiler" value="jikes"/>-->:g' -i build.xml
}

src_install() {
	java-pkg_newjar "packages/portagemaster-${PV}.jar"
	java-pkg_dolauncher
}

pkg_postinst() {
	einfo "Programs needed for default configuration to work are"
	einfo "xterm,nano (for editor) and mozilla (for browser)"
	einfo "You can change these in ~/.portagemaster/conf file"
}
