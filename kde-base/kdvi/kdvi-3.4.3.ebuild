# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdvi/kdvi-3.4.3.ebuild,v 1.7 2005/12/10 06:16:00 chriswhite Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE DVI viewer"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"
IUSE="tetex"
OLDDEPEND="~kde-base/kviewshell-$PV"
DEPEND="
$(deprange $PV $MAXKDEVER kde-base/kviewshell)
>=media-libs/freetype-2"
RDEPEND="${DEPEND}
	tetex? (
	|| ( >=app-text/tetex-2
	app-text/ptex
	app-text/cstetex
	app-text/dvipdfm )
	)"

KMCOMPILEONLY="kviewshell/"
