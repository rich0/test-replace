# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ladspa/gst-plugins-ladspa-0.10.7.ebuild,v 1.3 2008/08/07 21:33:53 klausman Exp $

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ~x86"
IUSE=""

DEPEND=">=media-libs/ladspa-sdk-1.12-r2
	>=media-libs/gst-plugins-base-0.10.19
	>=media-libs/gstreamer-0.10.19"
