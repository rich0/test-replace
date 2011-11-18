# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomad/gnomad-2.9.6.ebuild,v 1.2 2011/11/18 12:05:03 ssuominen Exp $

EAPI=4

MY_PN=${PN}2
MY_P=${MY_PN}-${PV}

DESCRIPTION="A GTK+ music manager and swiss army knife for the Portable Digital Entertainment (PDE) protocol"
HOMEPAGE="http://gnomad2.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="nls"

RDEPEND="media-libs/libid3tag
	media-libs/libmtp
	media-libs/libnjb
	media-libs/taglib
	>=x11-libs/gtk+-2.24:2
	|| ( >=sys-fs/udev-171-r1[gudev] <sys-fs/udev-171-r1[extras] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

DOCS=( AUTHORS README TODO ) # ChangeLog and NEWS are both outdated

src_configure() {
	econf $(use_enable nls)
}
