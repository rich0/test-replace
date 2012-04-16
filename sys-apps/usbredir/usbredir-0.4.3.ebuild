# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbredir/usbredir-0.4.3.ebuild,v 1.2 2012/04/16 20:07:30 ssuominen Exp $

EAPI=4

DESCRIPTION="A simple TCP daemon and set of libraries for the usbredir protocol (redirecting USB traffic)"
HOMEPAGE="http://spice-space.org/page/UsbRedir"
SRC_URI="http://spice-space.org/download/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

#Force 1.0.9_rc here until virtual/libusb:1 has been updated to 1.0.9_rc
RDEPEND=">=dev-libs/libusb-1.0.9_rc
	virtual/libusb:1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="ChangeLog README* TODO *.txt"

src_prepare() {
	sed -i -e 's:-Werror::' configure || die
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	rm -f "${ED}"/usr/lib*/lib*.la
}
