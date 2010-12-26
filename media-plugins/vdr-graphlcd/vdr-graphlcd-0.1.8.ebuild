# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-graphlcd/vdr-graphlcd-0.1.8.ebuild,v 1.2 2010/12/26 22:55:44 hd_brummy Exp $

EAPI="2"

inherit eutils vdr-plugin

DESCRIPTION="VDR Graphical LCD Plugin"
HOMEPAGE="http://projects.vdr-developer.org/projects/graphlcd"
SRC_URI="http://projects.vdr-developer.org/attachments/download/429/${P}.tgz"

KEYWORDS="~x86 ~amd64"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6
	>=app-misc/graphlcd-base-0.1.7"
RDEPEND="${DEPEND}"

pkg_setup() {
	vdr-plugin_pkg_setup

	if ! getent group lp | grep -q vdr; then
		echo
		einfo "Add user 'vdr' to group 'lp' for full user access to parport device"
		echo
		elog "User vdr added to group lp"
		gpasswd -a vdr lp
	fi
	if ! getent group usb | grep -q vdr; then
		echo
		einfo "Add user 'vdr' to group 'usb' for full user access to usb device"
		echo
		elog "User vdr added to group usb"
		gpasswd -a vdr usb
	fi
}

src_prepare() {
	vdr-plugin_src_prepare

	sed -i "s:/usr/local:/usr:" Makefile

	sed -i "s:i18n.c:i18n.h:g" Makefile

	if ! has_version ">=media-video/vdr-1.7.13"; then
		sed -i "s:include \$(VDRDIR)/Make.global:#include \$(VDRDIR)/Make.global:" Makefile
	fi
}

src_install() {

	vdr-plugin_src_install

	insopts -m0644 -ovdr -gvdr

	insinto /usr/share/vdr/${VDRPLUGIN}/logos
	doins -r ${VDRPLUGIN}/logos/*

	insinto /usr/share/vdr/${VDRPLUGIN}/fonts
	doins ${VDRPLUGIN}/fonts/*.fnt

	for font in /usr/share/fonts/corefonts/*.ttf; do
		elog ${font}
		dosym ${font} /usr/share/vdr/graphlcd/fonts
	done

	insinto /etc/vdr/plugins/${VDRPLUGIN}
	doins ${VDRPLUGIN}/logonames.alias.*
	doins ${VDRPLUGIN}/fonts.conf.*

	dosym /usr/share/vdr/${VDRPLUGIN}/fonts /etc/vdr/plugins/${VDRPLUGIN}/fonts
	dosym /usr/share/vdr/${VDRPLUGIN}/logos /etc/vdr/plugins/${VDRPLUGIN}/logos
	dosym /etc/graphlcd.conf /etc/vdr/plugins/${VDRPLUGIN}/graphlcd.conf

	dosym /etc/vdr/plugins/${VDRPLUGIN}/logonames.alias.1.3 /etc/vdr/plugins/${VDRPLUGIN}/logonames.alias
}

pkg_preinst() {

	if [[ -e /etc/vdr/plugins/graphlcd/fonts ]] && [[ ! -L /etc/vdr/plugins/graphlcd/fonts ]] \
	|| [[ -e /etc/vdr/plugins/graphlcd/logos ]] && [[ ! -L /etc/vdr/plugins/graphlcd/logos ]] ;then

		elog "Remove wrong DIR in /etc/vdr/plugins/graphlcd from prior install"
		elog "Press CTRL+C to abbort"
		epause
		rmdir -R /etc/vdrplugins/graphlcd/{fonts,logos}
	fi
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	elog "Add additional options in /etc/conf.d/vdr.graphlcd"
	elog
	elog "Please copy or link one of the supplied fonts.conf.*"
	elog "files in /etc/vdr/plugins/graphlcd/ to"
	elog "/etc/vdr/plugins/graphlcd/fonts.conf"
}
