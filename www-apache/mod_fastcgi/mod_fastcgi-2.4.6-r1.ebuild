# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_fastcgi/mod_fastcgi-2.4.6-r1.ebuild,v 1.4 2012/01/02 21:29:45 ulm Exp $

inherit apache-module eutils

DESCRIPTION="FastCGI is a open extension to CGI without the limitations of server specific APIs."
HOMEPAGE="http://fastcgi.com/"
SRC_URI="http://www.fastcgi.com/dist/${P}.tar.gz"

KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="mod_fastcgi"
IUSE=""

APXS2_ARGS="-c mod_fastcgi.c fcgi*.c"
APACHE2_MOD_CONF="20_${PN}"
APACHE2_MOD_DEFINE="FASTCGI"

DOCFILES="CHANGES README docs/LICENSE.TERMS docs/mod_fastcgi.html"

need_apache

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-graceful.patch
}
