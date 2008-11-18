# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/po4a/po4a-0.29.ebuild,v 1.2 2008/11/18 15:59:50 tove Exp $

inherit eutils perl-app

DESCRIPTION="Tools for helping translation of documentation"
HOMEPAGE="http://${PN}.alioth.debian.org"
SRC_URI="mirror://debian/pool/main/p/po4a/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/SGMLSpm
	>=sys-devel/gettext-0.13
	>=virtual/perl-Module-Build-0.28
	app-text/openjade
	dev-perl/Locale-gettext
	dev-perl/TermReadKey
	dev-perl/Text-WrapI18N"

src_compile() {
	rm "${S}"/Makefile
	perl-app_src_compile
}
