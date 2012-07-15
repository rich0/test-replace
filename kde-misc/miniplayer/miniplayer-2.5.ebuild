# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/miniplayer/miniplayer-2.5.ebuild,v 1.1 2012/07/15 19:35:12 johu Exp $

EAPI=4

KDE_LINGUAS_DIR="applet/locale"
KDE_LINGUAS="de et pl pt ru sv uk"
inherit kde4-base

DESCRIPTION="Multimedia player plasmoid"
HOMEPAGE="http://kde-look.org/content/show.php?content=95501"
SRC_URI="http://kde-look.org/CONTENT/content-files/95501-${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	media-libs/phonon
"
RDEPEND="
	${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"

src_prepare() {
	local lang
	for lang in ${KDE_LINGUAS} ; do
		if ! use linguas_${lang} ; then
			rm ${KDE_LINGUAS_DIR}/${lang}.mo
		fi
	done

	kde4-base_src_prepare
}
