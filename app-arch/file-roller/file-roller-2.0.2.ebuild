# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/file-roller/file-roller-2.0.2.ebuild,v 1.3 2002/12/09 04:17:36 manson Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="File Roller is an archive manager for the GNOME environment."
SRC_URI="mirror://sourceforge/${PN/-/}/${P}.tar.gz"
HOMEPAGE="http://fileroller.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND=">=x11-libs/gtk+-2.0.5
	>=gnome-base/gnome-vfs-2.0.0	
	>=gnome-base/libglade-2.0.0	
	>=gnome-base/bonobo-activation-1.0.0
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/nautilus-2.0.0"

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO"
