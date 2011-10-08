# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unpaper/unpaper-0.4.ebuild,v 1.1 2011/10/08 19:47:36 flameeyes Exp $

EAPI=4

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="git://github.com/Flameeyes/unpaper.git"
	inherit git-2 autotools
else
	SRC_URI="http://www.flameeyes.eu/files/${P}.tar.xz"
fi

DESCRIPTION="Post-processor for scanned and photocopied book pages"
HOMEPAGE="http://www.flameeyes.eu/projects/unpaper"

LICENSE="GPL-2"

KEYWORDS=""
SLOT="0"
IUSE="test"

DEPEND="test? ( media-libs/netpbm[png] )
	dev-libs/libxslt
	app-text/docbook-xsl-ns-stylesheets"
RDEPEND=""

if [[ ${PV} == 9999 ]]; then
	src_prepare() {
		eautoreconf
	}
fi

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		--htmldir=/usr/share/doc/${PF}/html
}

src_test() {
	emake check
}
