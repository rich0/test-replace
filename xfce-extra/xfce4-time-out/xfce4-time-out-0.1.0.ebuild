# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-time-out/xfce4-time-out-0.1.0.ebuild,v 1.3 2007/05/12 15:43:55 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="Panel plugin for taking break from computer work."
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="debug"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-lang/perl"

DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"

xfce44_goodies_panel_plugin
