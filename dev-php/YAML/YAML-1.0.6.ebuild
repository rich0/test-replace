# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/YAML/YAML-1.0.6.ebuild,v 1.1 2012/06/22 17:33:51 mabi Exp $

EAPI=4

PEAR_PV="1.0.6"
PHP_PEAR_PKG_NAME="YAML"

inherit php-pear-r1

DESCRIPTION="The Symfony YAML Component."
HOMEPAGE="pear.symfony-project.com"
SRC_URI="http://pear.symfony-project.com//get/YAML-1.0.6.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/php-5.2.4
	>=dev-php/pear-1.4.1"
RDEPEND="${DEPEND}"
