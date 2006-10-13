# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome2-user-docs/gnome2-user-docs-2.16.1.ebuild,v 1.1 2006/10/13 17:21:51 leio Exp $

inherit gnome2

MY_PN="gnome-user-docs"
S=${WORKDIR}/${MY_PN}-${PV}
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP[0]}.${PVP[1]}/${MY_PN}-${PV}.tar.bz2"

DESCRIPTION="GNOME end user documentation"
HOMEPAGE="http://www.gnome.org/"

LICENSE="FDL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND="app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.5.6"

DOCS="AUTHORS ChangeLog NEWS README"

# Parallel make doesn't always work (bug #135955)
MAKEOPTS="${MAKEOPTS} -j1"


pkg_setup() {
	G2CONF="--disable-scrollkeeper"
}
