# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kavi2svcd/kavi2svcd-0.8a.ebuild,v 1.1 2003/10/19 02:33:53 vapier Exp $

inherit kde-base
need-kde 3

DESCRIPTION="GUI for generating VCD-compliant MPEG files from an AVI or MPEG file"
HOMEPAGE="http://kavi2svcd.sourceforge.net/"
SRC_URI="mirror://sourceforge/kavi2svcd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=media-video/transcode-0.6.6
	>=media-video/mjpegtools-1.6.0-r7
	cdr? ( >=media-video/vcdimager-0.7.14
		>=app-cdr/cdrdao-1.1.7-r1 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.patch
}
