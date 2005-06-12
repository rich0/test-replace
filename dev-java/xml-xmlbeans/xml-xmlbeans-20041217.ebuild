# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xml-xmlbeans/xml-xmlbeans-20041217.ebuild,v 1.8 2005/06/12 12:59:31 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="An XML-Java binding tool"
HOMEPAGE="http://xmlbeans.apache.org/"
SRC_URI="http://dev.gentoo.org/~karltk/projects/java/distfiles/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="x86 amd64 ~ppc"
IUSE="doc junit source"

DEPEND=">=virtual/jdk-1.4
	junit? ( >=dev-java/ant-1.6.2 )
	!junit? ( >=dev-java/ant-core-1.6.2 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4
	=dev-java/jaxen-1.1*
	junit? ( >=dev-java/junit-3.8 )"

S=${WORKDIR}/${P}/v1

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/xml-xmlbeans-gentoo.patch

	cd ${S}/external/lib
	rm -f jaxen-1.1-beta-2.jar junit.jar

	java-pkg_jar-from jaxen-1.1 jaxen.jar jaxen-1.1-beta-2.jar
	if has_version dev-java/ant-tasks; then
		if use junit; then
			java-pkg_jar-from junit
		fi
	fi
}

src_compile() {
	local antflags="xbean.jar"
	use doc && antflags="${antflags} docs"
	if has_version dev-java/ant-tasks; then
		if use junit; then
			antflags="${antflags} random.jar drt.jar drt"
		fi
	fi
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar build/lib/xbean*.jar

	dodoc CHANGES.txt NOTICE.txt README.txt
	use doc && java-pkg_dohtml -r build/docs/*
	use source && java-pkg_dosrc src/*
}
