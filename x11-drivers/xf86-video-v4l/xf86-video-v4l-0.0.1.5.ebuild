# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-v4l/xf86-video-v4l-0.0.1.5.ebuild,v 1.13 2006/10/11 00:27:00 dberkholz Exp $

# Must be before x-modular eclass is inherited
# SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="video4linux driver"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ppc64 ~sh ~sparc x86"
IUSE=""
RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/randrproto
	x11-proto/videoproto
	x11-proto/xproto"
