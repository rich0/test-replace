# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-sndfile/xmms-sndfile-1.2.ebuild,v 1.9 2004/12/31 09:54:40 corsair Exp $

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Xmms_sndfile is a libsndfile plugin for XMMS"
HOMEPAGE="http://www.mega-nerd.com/xmms_sndfile/"
SRC_URI="http://www.mega-nerd.com/xmms_sndfile/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ~ppc sparc x86 ~ppc64"
IUSE=""

DEPEND="media-libs/libsndfile
	media-sound/xmms"

src_install() {
	make DESTDIR=${D} libdir=`xmms-config --input-plugin-dir` install || die
	dodoc AUTHORS NEWS README ChangeLog TODO
}
