# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/openfire/openfire-3.3.0.ebuild,v 1.2 2007/05/08 22:46:00 genone Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Openfire (formerly wildfire) real time collaboration (RTC) server"
HOMEPAGE="http://www.igniterealtime.org/projects/openfire/"
SRC_URI="http://www.igniterealtime.org/builds/openfire/${PN//-/_}_src_${PV//./_}.tar.gz"
RESTRICT=""
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE="doc"

# For transports
PROVIDE="virtual/jabber-server"

RDEPEND=" >=virtual/jre-1.5 "
# Doesn't build against Java 1.6 due to changes in JDBC API
DEPEND="net-im/jabber-base
		=virtual/jdk-1.5*
		>=dev-java/ant-1.6
		<dev-java/ant-1.7
		dev-java/ant-contrib
		>=dev-java/commons-net-1.4"

S=${WORKDIR}/${PN//-/_}_src

pkg_setup() {
	if [ -f /etc/env.d/98openfire ]; then
		einfo "This is an upgrade"
	else
		ewarn "If this is an upgrade stop right ( CONTROL-C ) and run the command:"
		ewarn "echo 'CONFIG_PROTECT=\"/opt/openfire/resources/security/\"' > /etc/env.d/98openfire "
		ewarn "For more info see bug #139708"
		sleep 11
	fi
}

src_unpack() {
	unpack ${PN//-/_}_src_${PV//./_}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/buildxml-${PV}.patch

	# TODO should replace jars in build/lib with ones packaged by us -nichoj
}

src_compile() {
	# Jikes doesn't support -source 1.5
	java-pkg_filter-compiler jikes

	eant -f build/build.xml openfire plugins plugins-dev $(use_doc)
}

src_install() {
	dodir /opt/openfire

	doinitd ${FILESDIR}/init.d/openfire
	doconfd ${FILESDIR}/conf.d/openfire

	dodir /opt/openfire/conf
	insinto /opt/openfire/conf
	newins target/openfire/conf/openfire.xml openfire.xml.sample

	dodir /opt/openfire/logs
	keepdir /opt/openfire/logs

	dodir /opt/openfire/lib
	insinto /opt/openfire/lib
	doins target/openfire/lib/*

	dodir /opt/openfire/plugins
	insinto /opt/openfire/plugins
	doins -r target/openfire/plugins/*

	dodir /opt/openfire/resources
	insinto /opt/openfire/resources
	doins -r target/openfire/resources/*

	if use doc; then
		dohtml -r documentation/docs/*
	fi
	dodoc documentation/dist/*

	#Protect ssl key on upgrade
	dodir /etc/env.d/
	echo 'CONFIG_PROTECT="/opt/openfire/resources/security/"' > ${D}/etc/env.d/98openfire
}

pkg_postinst() {
	chown -R jabber:jabber /opt/openfire

	ewarn If this is a new install, please edit /opt/openfire/conf/openfire.xml.sample
	ewarn and save it as /opt/openfire/conf/openfire.xml
	ewarn
	ewarn The following must be be owned or writable by the jabber user.
	ewarn /opt/openfire/conf/openfire.xml
	ewarn
	ewarn If you are upgrading please have a look at the Wildfire to Openfire Upgrade Guide:
	ewarn http://wiki.igniterealtime.org/display/WILDFIRE/Wildfire+to+Openfire+Upgrade+Guide
	ewarn
}
