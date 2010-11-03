# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-icons/kdepim-icons-4.4.7.ebuild,v 1.2 2010/11/03 20:56:39 hwoarang Exp $

EAPI="3"

KMNAME="kdepim"
KMMODULE="icons"
inherit kde4-meta

DESCRIPTION="KDE PIM icons"
IUSE=""
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"

src_install() {
	kde4-meta_src_install
	# colliding with oxygen icons
	rm -rf "${ED}"/${KDEDIR}/share/icons/oxygen/16x16/status/meeting-organizer.png
}
