# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpovmodeler/kpovmodeler-3.5.0.ebuild,v 1.4 2005/12/12 17:19:48 josejx Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Modeler for POV-Ray Scenes"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="virtual/opengl
	>=media-libs/freetype-2"
RDEPEND="${DEPEND}
	media-gfx/povray"
