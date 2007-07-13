# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-news/eselect-news-20070709.ebuild,v 1.3 2007/07/13 06:07:37 mr_bones_ Exp $

DESCRIPTION="GLEP 42 news reader"
HOMEPAGE="http://paludis.pioto.org/"
SRC_URI="http://paludis.pioto.org/download/news.eselect-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

RDEPEND="app-admin/eselect sys-apps/paludis"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${DISTDIR}/news.eselect-${PV}" news.eselect || die
}
