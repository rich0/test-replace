# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/gtk-v4l/gtk-v4l-0.4.ebuild,v 1.1 2012/05/11 09:28:45 ssuominen Exp $

EAPI=4
inherit eutils

DESCRIPTION="A control application for Video 4 Linux (based on C and GTK+)"
HOMEPAGE="http://fedorahosted.org/gtk-v4l/"
SRC_URI="http://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=media-libs/libv4l-0.6
	|| ( >=sys-fs/udev-171-r5[gudev] <sys-fs/udev-171[extras] )
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog README"

src_prepare() {
	epatch "${FILESDIR}"/${P}-device-remove-source-on-finalize.patch
	sed -i -e '/^Categories/s:Application:GTK:' ${PN}.desktop.in || die
}

src_configure() {
	econf --disable-static
}

src_install() {
	default
	rm -f "${ED}"/usr/lib*/lib*.la
}
