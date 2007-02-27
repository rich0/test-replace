# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xdoclet/xdoclet-1.2.3.ebuild,v 1.3 2007/02/27 16:58:09 caster Exp $

JAVA_PKG_IUSE="source"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="XDoclet is an extended Javadoc Doclet engine."
HOMEPAGE="http://xdoclet.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

CDEPEND="=dev-java/bsf-2.3*
	dev-java/commons-collections
	dev-java/commons-logging
	dev-java/log4j
	dev-java/mockobjects
	dev-java/velocity
	dev-java/xjavadoc
	dev-java/junit"
# needs javatoolkit with proper xml-rewriting with entities
DEPEND=">=dev-java/javatoolkit-0.2.0-r1
	>=virtual/jdk-1.4
	dev-java/ant
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"


src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-interface.patch
	epatch ${FILESDIR}/${P}-buildfile.patch

	cd ${S}/lib && rm -f *.jar
	java-pkg_jar-from xjavadoc
	java-pkg_jar-from bsf-2.3
	java-pkg_jar-from velocity
	java-pkg_jar-from log4j
	java-pkg_jar-from mockobjects
	java-pkg_jar-from commons-logging
	java-pkg_jar-from commons-collections
	java-pkg_jar-from velocity
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from junit
}

# TODO investigate why compiling needs junit, ie is build not sane enough to
# devide building of test classes separate from rest of classes?
src_compile() {
	eant core modules maven
}

src_install() {
	for jar in target/lib/*.jar; do
		java-pkg_newjar ${jar} $(basename ${jar/-${PV}/})
	done

	dodoc README.txt
	use source && java-pkg_dosrc core/src/xdoclet modules/*
}

