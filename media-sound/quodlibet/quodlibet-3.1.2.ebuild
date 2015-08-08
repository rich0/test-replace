# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 gnome2-utils fdo-mime

DESCRIPTION="audio library tagger, manager, and player for GTK+"
HOMEPAGE="http://code.google.com/p/quodlibet/"
SRC_URI="http://bitbucket.org/lazka/${PN}-files/raw/default/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="+dbus gstreamer ipod +udev"

RDEPEND="dev-libs/keybinder:3[introspection]
	dev-python/feedparser[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	>=media-libs/mutagen-1.22[${PYTHON_USEDEP}]
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
		media-libs/gst-plugins-good:1.0
		media-plugins/gst-plugins-meta:1.0
		)
	!gstreamer? ( media-libs/xine-lib )
	dbus? (
		app-misc/media-player-info
		dev-python/dbus-python[${PYTHON_USEDEP}]
		)
	ipod? ( media-libs/libgpod[python,${PYTHON_USEDEP}] )
	udev? ( virtual/udev )"
DEPEND="dev-util/intltool"
REQUIRED_USE="ipod? ( dbus )"

src_prepare() {
	sed -i -e '/usr.*bin.*env/s:python:python2:' {exfalso,quodlibet}.py || die

	local qlconfig=${PN}/config.py

	if ! use gstreamer; then
		sed -i -e '/backend/s:gstbe:xinebe:' ${qlconfig} || die
	fi

	sed -i -e '/gst_pipeline/s:"":"alsasink":' ${qlconfig} || die

	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install
	dodoc NEWS README
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
