# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/liferea/liferea-0.9.6.ebuild,v 1.7 2006/01/12 23:25:53 compnerd Exp $

inherit gnome2

DESCRIPTION="News Aggregator for RDF/RSS/CDF/Atom/Echo/etc feeds"
HOMEPAGE="http://liferea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 ~sparc x86"
IUSE="mozilla gtkhtml"

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/libxml2-2.5.10
	mozilla? ( www-client/mozilla
		gtkhtml? ( =gnome-extra/gtkhtml-2* )
	)
	!mozilla? ( =gnome-extra/gtkhtml-2* )
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="README AUTHORS ChangeLog COPYING"

