# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jaaa/jaaa-0.1.1.ebuild,v 1.1 2004/10/09 22:32:58 trapni Exp $

DESCRIPTION="The JACK and ALSA Audio Analyser is an audio signal generator and spectrum analyser designed to make accurate measurements."
HOMEPAGE="http://users.skynet.be/solaris/linuxaudio"
SRC_URI="http://users.skynet.be/solaris/linuxaudio/downloads/${P}.tar.bz2"
LICENSE="GPL-2"
RESTRICT=""
IUSE=""

SLOT="0"
KEYWORDS="~x86"

DEPEND="
	>=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.7.2
	virtual/glibc
	virtual/jack
	media-libs/alsa-lib
	>=media-libs/libclalsadrv-1.0.0
	>=media-libs/libclthreads-1.0.0
	>=media-libs/libclxclient-1.0.0
	>=dev-libs/fftw-3.0.0
	>=x11-libs/gtk+-2.0.0
"

src_compile() {
	emake || die
}

src_install() {
	dobin jaaa
	dodoc COPYING AUTHORS INSTALL README
}
