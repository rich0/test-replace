# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/xawdecode/xawdecode-1.8.0.ebuild,v 1.10 2004/08/29 10:57:14 mholzer Exp $

IUSE="alsa jpeg encode ffmpeg xvid lirc xosd"

DESCRIPTION="TV viewer with support for AVI recording and plugins"
HOMEPAGE="http://xawdecode.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"

RDEPEND="virtual/x11
	>=media-libs/zvbi-0.2.4
	|| ( x11-libs/neXtaw x11-libs/Xaw3d )
	x86? ( >=media-libs/divx4linux-20030428 )
	ffmpeg? ( >=media-video/ffmpeg-0.4.7 )
	xvid? ( >=media-libs/xvid-0.9.1 )
	encode? ( >=media-sound/lame-3.93 )
	jpeg? ( media-libs/jpeg )
	lirc? ( app-misc/lirc )
	alsa? ( media-libs/alsa-lib media-sound/alsa-utils )
	xosd? ( >=x11-libs/xosd-2.2.2 )"

DEPEND="${RDEPEND}
	sys-apps/sed"

src_compile() {
	local myconf

	use x86 \
		&& myconf="${myconf} --enable-divx4linux" \
		|| myconf="${myconf} --disable-divx4linux"

	econf \
		`use_enable alsa` \
		`use_enable jpeg` \
		`use_enable lirc` \
		`use_enable ffmpeg` \
		`use_enable xvid` \
		`use_enable xosd` \
		${myconf} || die "Configuration failed."

	emake PERF_FLAGS="${CFLAGS}" || die "Compilation failed."
	# Or should we keep the optimized flags they suggest?
	#emake || die "Compilation failed."
}

src_install() {

	sed -i "/^SUBDIRS=/s:font::" Makefile

	insinto /usr/X11R6/lib/X11/fonts/misc
	doins font/led-fixed.pcf

	insinto /usr/share/applications
	doins gentoo/xawdecode.desktop

	einstall \
		ROOT=${D} || die "Installation failed."

	dodoc COPYING ChangeLog AUTHORS INSTALL
	dodoc FAQ* README.* lisez-moi*
	dodoc xawdecoderc.sample
	dodoc lircrc.*.sample

}

pkg_postinst() {
	einfo "Please note that this ebuild created a suid-binary:"
	einfo "/usr/bin/xawdecode_v4l-conf"
}
