# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/juk/juk-4.3.5.ebuild,v 1.3 2010/03/11 18:33:59 ranger Exp $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="Jukebox and music manager for KDE."
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook musicbrainz"

DEPEND="
	>=media-libs/taglib-1.5
	musicbrainz? ( media-libs/tunepimp )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with musicbrainz TunePimp)
	)

	kde4-meta_src_configure
}
