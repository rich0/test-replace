# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-xvideo/gst-plugins-xvideo-0.8.9.ebuild,v 1.1 2005/06/08 15:29:40 zaheerm Exp $

inherit gst-plugins

KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE=""
DEPEND="virtual/x11"

# xshm is a compile time option of xvideo
GST_PLUGINS_BUILD="x xvideo xshm"
GST_PLUGINS_BUILD_DIR="xvimage"
