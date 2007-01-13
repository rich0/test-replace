# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_external/mod_auth_external-2.1.19.ebuild,v 1.3 2007/01/13 20:09:01 chtekk Exp $

inherit eutils apache-module

DESCRIPTION="Apache External Authentication Module"
HOMEPAGE="http://www.unixpapa.com/mod_auth_external.html"
SRC_URI="http://www.unixpapa.com/software/${P}.tar.gz"

DEPEND=""
LICENSE="Apache-1.1"
KEYWORDS="~x86"
IUSE=""
SLOT="1"

DOCFILES="AUTHENTICATORS CHANGES INSTALL INSTALL.HARDCODE README TODO"

APACHE1_MOD_CONF="10_${PN}"
APACHE1_MOD_DEFINE="AUTH_EXTERNAL"

need_apache1
