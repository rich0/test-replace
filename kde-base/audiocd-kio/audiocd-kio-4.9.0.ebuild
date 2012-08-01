# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/audiocd-kio/audiocd-kio-4.9.0.ebuild,v 1.1 2012/08/01 22:17:13 johu Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE kioslaves from the kdemultimedia package"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug encode flac vorbis"

# 4 of 9 tests fail. Last checked for 4.2.88
RESTRICT=test

DEPEND="
	$(add_kdebase_dep libkcddb)
	$(add_kdebase_dep libkcompactdisc)
	media-sound/cdparanoia
	encode? (
		flac? ( >=media-libs/flac-1.1.2 )
		vorbis? ( media-libs/libvorbis )
	)
"
RDEPEND="${DEPEND}"

add_blocker kdemultimedia-kioslaves

KMLOADLIBS="libkcddb"

src_configure() {
	if use encode; then
		mycmakeargs=(
			$(cmake-utils_use_with flac)
			$(cmake-utils_use_with vorbis OggVorbis)
		)
	else
		mycmakeargs=(-DWITH_OggVorbis=OFF -DWITH_Flac=OFF)
	fi

	kde4-base_src_configure
}
