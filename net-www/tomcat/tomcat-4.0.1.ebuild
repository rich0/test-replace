# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/tomcat/tomcat-4.0.1.ebuild,v 1.9 2002/08/16 03:01:02 murphy Exp $

S=${WORKDIR}/jakarta-${P}
DESCRIPTION="Apache Servlet Engine"
SRC_URI="http://jakarta.apache.org/builds/jakarta-tomcat-4.0/release/v${PV}/bin/jakarta-tomcat-4.0.1.tar.gz"
HOMEPAGE="http://jakarta.apache.org/tomcat"
KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="Apache-1.1"

RDEPEND=">=virtual/jdk-1.2"

src_install() {
	dodir /opt/jakarta/tomcat
	dodir /opt/jakarta/tomcat/logs
	dodoc RELEASE-NOTES-* README.txt RUNNING.txt LICENSE
	cp -Rdp bin common conf lib server webapps work ${D}/opt/jakarta/tomcat
	dodir /etc/env.d
	insinto /etc/env.d
	doins ${FILESDIR}/21tomcat
}








