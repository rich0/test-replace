# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jarjar/jarjar-0.6-r1.ebuild,v 1.8 2007/05/26 17:26:12 nelchael Exp $

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Tool for repackaging third-party jars."
SRC_URI="mirror://sourceforge/jarjar/${PN}-src-${PV}.zip"
HOMEPAGE="http://jarjar.sourceforge.net"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
COMMON_DEP="
	=dev-java/asm-2.0*
	=dev-java/gnu-regexp-1*
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"

# FIXME looks like it bundles stuff from dev-java/java-getopt, ie
# gnu.getopt.*, so this should delete the bundled files, and then
# depend on java-getopt. Should also probably report upstream. -nichoj

src_unpack() {
	unpack ${A}

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from asm-2
	java-pkg_jar-from gnu-regexp-1
	java-pkg_jar-from ant-core ant.jar
}

src_install() {
	java-pkg_newjar dist/${P}.jar ${PN}.jar

	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src/main/*
}
