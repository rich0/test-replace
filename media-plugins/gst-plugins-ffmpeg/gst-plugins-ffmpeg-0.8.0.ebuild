# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ffmpeg/gst-plugins-ffmpeg-0.8.0.ebuild,v 1.3 2004/04/15 00:03:50 weeve Exp $

inherit gst-plugins

MY_PN=${PN/-plugins/}
MY_P=${MY_PN}-${PV}

DESCRIPTION="FFmpeg based gstreamer plugin"
SRC_URI="http://gstreamer.freedesktop.org/src/${MY_PN}/${MY_P}.tar.bz2"

KEYWORDS="~x86 ~ppc ~sparc"

IUSE=""

S=${WORKDIR}/${MY_P}

DEPEND=">=media-libs/gstreamer-0.8
	dev-util/pkgconfig"

# overrides gst_plugins_src_unpack
src_unpack() {

	unpack ${A}

}

src_compile() {

	econf || die
	emake || die

}

src_install() {

	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO

}
