# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-bh-lucidatypewriter-100dpi/font-bh-lucidatypewriter-100dpi-0.99.0.ebuild,v 1.4 2005/08/14 23:51:06 spyderous Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular


DESCRIPTION="BigReqs prototype headers"
KEYWORDS="~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/mkfontdir
	x11-apps/mkfontscale
	x11-apps/bdftopcf
	media-fonts/font-util"

CONFIGURE_OPTIONS="--with-mapfiles=${XDIR}/share/fonts/util"

src_unpack() {
	x-modular_unpack_source
	x-modular_patch_source

	sed -i -e "s:^fontdir =.*:fontdir = \$(datadir)/fonts/\$(FONT_DIR):g" \
		${S}/Makefile.am

	x-modular_reconf_source
}
