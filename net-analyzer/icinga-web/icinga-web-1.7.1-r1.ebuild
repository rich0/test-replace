# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/icinga-web/icinga-web-1.7.1-r1.ebuild,v 1.2 2012/07/22 00:33:57 idl0r Exp $

EAPI="2"

inherit depend.apache eutils user multilib

DESCRIPTION="Icinga Web - new Web Interface"
HOMEPAGE="http://www.icinga.org/"
SRC_URI="mirror://sourceforge/icinga/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="apache2 mysql pnp postgres"
DEPEND="dev-php/phing
		dev-lang/php[apache2?,cli,mysql?,pdo,postgres?,json]
		pnp? ( net-analyzer/pnp4nagios )"
RDEPEND="${DEPEND}"

want_apache2

pkg_setup() {
	if use apache2 ; then
		depend.apache_pkg_setup
	fi
	enewgroup icinga
	enewgroup nagios
	enewuser icinga -1 -1 /var/lib/icinga "icinga,nagios"
}

src_prepare() {
	epatch "${FILESDIR}/${P}-disable-compression.patch"
}

src_configure() {
	local myconf

	myconf="--prefix=/usr/share/icinga/icinga-web
	--bindir=/usr/sbin
	--sbindir=/usr/$(get_libdir)/icinga/cgi-bin
	--datarootdir=/usr/share/icinga/htdocs
	--localstatedir=/var/lib/icinga
	--sysconfdir=/etc/icinga
	--libexecdir=/usr/$(get_libdir)/icinga/plugins
	--with-bin-user=icinga
	--with-bin-group=nagios
	--with-api-cmd-file=/var/lib/icinga/rw/icinga.cmd
	--with-conf-dir=/etc/icinga-web
	--with-log-dir=/var/log/icinga-web
	--with-icinga-objects-dir=/etc/icinga/objects
	--with-icinga-bin=/usr/sbin/icinga
	--with-icinga-cfg=/etc/icinga/icinga.cfg"

	if use apache2 ; then
		myconf+=" --with-web-user=apache
		--with-web-group=apache
		--with-web-apache-path=${APACHE_MODULES_CONFDIR}"
	else
		myconf+=" --with-web-user=root
		--with-web-group=root"
	fi

	if use postgres ; then
		myconf+=" --with-db-type=pgsql
		--with-db-port=5432
		--with-api-subtype=pgsql
		--with-api-port=5432"
	fi

	econf ${myconf}
}

src_install() {
	dodoc README
	rm -f README

	emake DESTDIR="${D}" install || die "make failed"

	emake DESTDIR="${D}" install-javascript || die "make failed"

	if use apache2 ; then
		dodir ${APACHE_MODULES_CONFDIR}
		emake DESTDIR="${D}" install-apache-config || die "make failed"
		echo '<IfDefine ICINGA_WEB>' > "${D}/${APACHE_MODULES_CONFDIR}/99_icinga-web.conf"
		cat "${D}/${APACHE_MODULES_CONFDIR}/icinga-web.conf" >> "${D}/${APACHE_MODULES_CONFDIR}/99_icinga-web.conf"
		echo '</IfDefine>' >> "${D}/${APACHE_MODULES_CONFDIR}/99_icinga-web.conf"
	fi

	insinto /usr/share/icinga/icinga-web/contrib
	doins -r etc/schema/* || die

	if use apache2 ; then
		sed -i 's/%%USER%%/apache/g'  etc/scheduler/icingaCron
	else
		sed -i 's/%%USER%%/root/g'  etc/scheduler/icingaCron
	fi
	sed -i 's/%%PATH%%/\/usr\/share\/icinga\/icinga-web/g' etc/scheduler/icingaCron

	insinto /etc/cron.d/
	doins etc/scheduler/icingaCron || die

	if use apache2 ; then
		diropts -o apache -g apache
	else
		diropts -o root -g root
	fi
	dodir /var/log/icinga-web

	if use apache2 ; then
		fowners apache:apache /usr/share/icinga/icinga-web/lib/icingaScheduler/res/storage.dat
	else
		fowners root:root /usr/share/icinga/icinga-web/lib/icingaScheduler/res/storage.dat
	fi

	if use pnp ; then
		insinto /usr/share/icinga/icinga-web/app/modules/Cronks/data/xml/extensions/
		doins contrib/PNP_Integration/templateExtensions/pnp-host-extension.xml
		doins contrib/PNP_Integration/templateExtensions/pnp-service-extension.xml
	fi
}

pkg_postinst() {
	einfo
	einfo "If this is a new install, you must create a new database for it, e.g. icinga_web."
	einfo "You can find the database scripts in /usr/share/icinga/icinga-web/contrib/."
	einfo
	einfo "Additionally, you need to setup a database user."
	einfo "The user must have default data privileges like SELECT, UPDATE, INSERT, DELETE."
	einfo
	einfo "Example for a MySQL database:"
	einfo "  echo \"CREATE DATABASE icinga_web;\" | mysql"
	einfo "  echo \"GRANT SELECT,UPDATE,INSERT,DELETE ON icinga_web.* TO 'icinga_web'@'localhost' IDENTIFIED BY 'xxxxxx';\" | mysql"
	einfo "  echo \"FLUSH PRIVILEGES;\" | mysql"
	einfo
	einfo "  cat /usr/share/icinga/icinga-web/contrib/mysql.sql | mysql icinga_web"
	einfo

	ewarn
	ewarn "If you're upgrading from a previous release, you must upgrade your database schema."
	ewarn "You can find upgrade scripts in /usr/share/icinga/icinga-web/contrib/updates/."
	ewarn
	ewarn "IMPORTANT: If you are upgrading from an older version and there are other versions in between,"
	ewarn "           be advised that you need to apply those upgrade files with incremental steps!"
	ewarn
	ewarn "Example to upgrade a MySQL database:"
	ewarn "  cat  /usr/share/icinga/icinga-web/contrib/updates/mysql_<oldversion>_to_<newversion>.sql | mysql icinga_web"
	ewarn
	ewarn "Don't forget to clear the config cache."
	ewarn "  /usr/share/icinga/icinga-web/bin/clearcache.sh"
	ewarn

	einfo
	einfo "Please note that the magic_quotes_gpc setting must be disabled (in both apache and cli php.ini)."
	einfo

	if use apache2 ; then
		einfo
		einfo "apache config was installed into"
		einfo "/etc/apache2/modules.d//99_icinga-web.conf"
		einfo
		einfo "The apache config value for \'ServerTokens\' must be set to at"
		einfo "least \'Min\'."
		einfo
	else
		einfo
		einfo "If you are not using apache you may need to change some"
		einfo "permissions, so that your web server can access files and logs"
		einfo
	fi
}
