# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-perl/gtk2-perl-1.012.ebuild,v 1.6 2005/01/15 14:08:03 corsair Exp $

inherit perl-module

MY_P=Gtk2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK2"
HOMEPAGE="http://gtk2-perl.sf.net/"
SRC_URI="mirror://sourceforge/gtk2-perl/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~alpha hppa ~amd64"
IUSE=""

DEPEND=">=x11-libs/gtk+-2*
	>=dev-perl/glib-perl-${PV}"
