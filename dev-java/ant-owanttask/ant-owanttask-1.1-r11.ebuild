# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-owanttask/ant-owanttask-1.1-r11.ebuild,v 1.3 2007/01/25 08:08:36 opfer Exp $

inherit java-ant-2 java-pkg-2 eutils

DESCRIPTION="ObjectWeb's Ant tasks"
HOMEPAGE="http://monolog.objectweb.org"
SRC_URI="http://www.gentoo.org/~karltk/java/distfiles/owanttask-${PV}-gentoo.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4
	dev-java/ant-core
	dev-java/xalan"
S=${WORKDIR}/owanttask-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-classpath.patch
	mkdir lib
	cd lib
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from xalan
}

src_compile() {
	eant jar
}

src_install() {
	java-pkg_dojar output/lib/ow_util_ant_tasks.jar
	dodir /usr/share/ant-core/lib
	dosym /usr/share/ant-owanttask/lib/ow_util_ant_tasks.jar /usr/share/ant-core/lib/
}

