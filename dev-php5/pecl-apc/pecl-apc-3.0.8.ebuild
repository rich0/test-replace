# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-apc/pecl-apc-3.0.8.ebuild,v 1.1 2005/09/04 16:20:56 stuart Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="APC"
PHP_EXT_NAME="apc"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1 confutils

IUSE="mmap"
DESCRIPTION="The Alternative PHP Cache."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~ppc ~x86"
DEPEND="${DEPEND}"

need_php_by_category

pkg_setup() {
	require_php_sapi_from cgi apache apache2
}

src_compile() {
	has_php

	# PECL-APC does not work with Zend Thread Safety (ZTS)
	# so abort if we are using PHP compiled with ZTS.
	if has_zts ; then
		eerror "PECL-APC doesn't work with a ZTS enabled PHP."
		eerror "Please disable ZTS by turning the 'threads'"
		eerror "USE flag off when you compile dev-lang/php."
		die "PECL-APC does not support ZTS"
	fi

	my_conf="--enable-apc"
	enable_extension_enable "apc-mmap" "mmap" 0
	enable_extension_with_built_with =${PHP_PKG} apache2 apxs2 /usr/sbin/apxs2 "optimisation for apache2"
	enable_extension_with_built_with =${PHP_PKG} apache apxs /usr/sbin/apxs "optimisation for apache1"
	php-ext-pecl-r1_src_compile
}

src_install() {
	php-ext-pecl-r1_src_install
	dodoc CHANGELOG INSTALL LICENSE NOTICE

	php-ext-base-r1_addtoinifiles "apc.enabled" '"1"'
	php-ext-base-r1_addtoinifiles "apc.shm_segments" '"1"'
	php-ext-base-r1_addtoinifiles "apc.shm_size" '"30"'
	php-ext-base-r1_addtoinifiles "apc.optimization" '"0"'
	php-ext-base-r1_addtoinifiles "apc.num_files_hint" '"1000"'
	php-ext-base-r1_addtoinifiles "apc.ttl" '"0"'
	php-ext-base-r1_addtoinifiles "apc.gc_ttl" '"3600"'
	php-ext-base-r1_addtoinifiles "apc.cache_by_default" '"1"'
	php-ext-base-r1_addtoinifiles "apc.filters" '""'
	php-ext-base-r1_addtoinifiles "apc.mmap_file_mask" '""'
	php-ext-base-r1_addtoinifiles "apc.slam_defense" '"0"'
	php-ext-base-r1_addtoinifiles "apc.file_update_protection" '"2"'

	dodir ${PHP_EXT_SHARED_DIR}
	insinto ${PHP_EXT_SHARED_DIR}
	doins apc.php
}

pkg_postinst() {
	einfo "The apc.php file shipped with this release of PECL-APC was"
	einfo "installed into /usr/share/php5/apc/."
}
