# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/eaccelerator/eaccelerator-0.9.5.ebuild,v 1.7 2006/11/10 14:24:14 gustavoz Exp $

PHP_EXT_NAME="eaccelerator"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="yes"

[[ -z "${EACCELERATOR_CACHEDIR}" ]] && EACCELERATOR_CACHEDIR="/var/cache/eaccelerator-php5/"

inherit php-ext-source-r1

KEYWORDS="~amd64 ~sparc ~x86"
DESCRIPTION="A PHP Accelerator & Encoder."
HOMEPAGE="http://www.eaccelerator.net/"
SRC_URI="mirror://sourceforge/eaccelerator/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE="contentcache debug disassembler session sharedmem"

DEPEND="!dev-php5/pecl-apc"
RDEPEND="${DEPEND}"

# Webserver user and group, here for Apache.
HTTPD_USER="apache"
HTTPD_GROUP="apache"

need_php_by_category

pkg_setup() {
	has_php

	require_php_sapi_from cgi apache apache2

	if use session ; then
		require_php_with_use session zlib
	else
		require_php_with_use zlib
	fi
}

src_compile() {
	has_php

	my_conf="--enable-eaccelerator=shared --with-eaccelerator-userid=`id -u ${HTTPD_USER}`"

	use contentcache && my_conf="${my_conf} --with-eaccelerator-content-caching"
	use debug && my_conf="${my_conf} --with-eaccelerator-debug"
	use disassembler && my_conf="${my_conf} --with-eaccelerator-disassembler"
	use session && my_conf="${my_conf} --with-eaccelerator-sessions"
	use sharedmem && my_conf="${my_conf} --with-eaccelerator-shared-memory"

	php-ext-source-r1_src_compile
}

src_install() {
	php-ext-source-r1_src_install

	keepdir "${EACCELERATOR_CACHEDIR}"
	fowners ${HTTPD_USER}:${HTTPD_GROUP} "${EACCELERATOR_CACHEDIR}"
	fperms 750 "${EACCELERATOR_CACHEDIR}"

	insinto "/usr/share/${PN}-php5/"
	doins -r doc/php/
	dodoc-php AUTHORS ChangeLog COPYING NEWS README README.eLoader

	php-ext-base-r1_addtoinifiles "eaccelerator.shm_size" '"28"'
	php-ext-base-r1_addtoinifiles "eaccelerator.cache_dir" "\"${EACCELERATOR_CACHEDIR}\""
	php-ext-base-r1_addtoinifiles "eaccelerator.enable" '"1"'
	php-ext-base-r1_addtoinifiles "eaccelerator.optimizer" '"1"'
	php-ext-base-r1_addtoinifiles "eaccelerator.debug" '"0"'
	php-ext-base-r1_addtoinifiles ";eaccelerator.log_file" '"/var/log/eaccelerator_log"'
	php-ext-base-r1_addtoinifiles "eaccelerator.check_mtime" '"1"'
	php-ext-base-r1_addtoinifiles "eaccelerator.filter" '""'
	php-ext-base-r1_addtoinifiles "eaccelerator.shm_max" '"0"'
	php-ext-base-r1_addtoinifiles "eaccelerator.shm_ttl" '"0"'
	php-ext-base-r1_addtoinifiles "eaccelerator.shm_prune_period" '"0"'
	php-ext-base-r1_addtoinifiles "eaccelerator.shm_only" '"0"'
	php-ext-base-r1_addtoinifiles "eaccelerator.compress" '"1"'
	php-ext-base-r1_addtoinifiles "eaccelerator.compress_level" '"9"'
	php-ext-base-r1_addtoinifiles "eaccelerator.keys" '"shm_and_disk"'
	php-ext-base-r1_addtoinifiles "eaccelerator.sessions" '"shm_and_disk"'
	php-ext-base-r1_addtoinifiles "eaccelerator.content" '"shm_and_disk"'
	php-ext-base-r1_addtoinifiles ";eaccelerator.allowed_admin_path" '"/path/where/admin/files/shall/be/allowed"'
}

pkg_postinst() {
	has_php

	# You only need to restart the webserver if you're using mod_php.
	if built_with_use =${PHP_PKG} apache || built_with_use =${PHP_PKG} apache2 ; then
		einfo
		einfo "You need to restart your Apache webserver to activate eAccelerator."
		einfo
	fi

	einfo
	einfo "Please see the files in ${ROOT}/usr/share/${PN}-php5/ for some examples"
	einfo "and information on how to use the functions that"
	einfo "eAccelerator adds to PHP."
	einfo
}
