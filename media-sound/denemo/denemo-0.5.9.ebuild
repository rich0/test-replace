# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/denemo/denemo-0.5.9.ebuild,v 1.7 2004/07/01 07:50:47 eradicator Exp $

DESCRIPTION="GTK+ graphical music notation editor"
HOMEPAGE="http://denemo.sourceforge.net/"
SRC_URI="http://dl.sourceforge.net/sourceforge/denemo/denemo-${PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc
	=x11-libs/gtk+-1.2*
	dev-libs/libxml
	dev-util/yacc
	sys-devel/flex
	sys-devel/gettext"
RDEPEND="virtual/libc
	=x11-libs/gtk+-1.2*
	dev-libs/libxml"

src_install() {
	make DESTDIR=${D} install || die
}
