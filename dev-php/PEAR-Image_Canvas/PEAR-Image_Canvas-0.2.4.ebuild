# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Image_Canvas/PEAR-Image_Canvas-0.2.4.ebuild,v 1.1 2006/01/28 07:16:48 sebastian Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Provides a common interface to image drawing, making image source
code independent on the library used."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="dev-php/PEAR-Image_Color"

pkg_setup() {
	require_gd
}
