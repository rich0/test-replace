# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PHP_TokenStream/PHP_TokenStream-1.1.3.ebuild,v 1.1 2012/06/22 17:34:42 mabi Exp $

EAPI=4

PEAR_PV="1.1.3"
PHP_PEAR_PKG_NAME="PHP_TokenStream"

inherit php-pear-r1

DESCRIPTION="Wrapper around PHP's tokenizer extension."
HOMEPAGE="pear.phpunit.de"
SRC_URI="http://pear.phpunit.de/get/PHP_TokenStream-1.1.3.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/php[tokenizer]
    >=dev-lang/php-5.2.7
	>=dev-php/pear-1.9.4"
RDEPEND="${DEPEND}"
