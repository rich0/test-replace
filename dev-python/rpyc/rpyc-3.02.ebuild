# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rpyc/rpyc-3.02.ebuild,v 1.3 2009/09/03 12:07:03 patrick Exp $
inherit distutils
DESCRIPTION="Remote python call"
HOMEPAGE="http://${PN}.wikidot.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="" # removing "~amd64 ~x86" because of upstream versioning change
IUSE="crypt"
RDEPEND="crypt? ( dev-python/tlslite )"
