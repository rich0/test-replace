# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdemud/cdemud-1.4.0.ebuild,v 1.1 2011/11/23 10:13:58 tetromino Exp $

EAPI="4"

DESCRIPTION="Daemon of the CDEmu optical media image mounting suite"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/cdemu-daemon-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pulseaudio"

RDEPEND=">=dev-libs/dbus-glib-0.61
	>=dev-libs/glib-2.14:2
	>=dev-libs/libmirage-${PV}
	>=media-libs/libao-0.8.0[pulseaudio?]
	sys-apps/dbus
	>=sys-fs/vhba-20101015
	!pulseaudio? ( >=media-libs/libao-0.8.0[alsa] )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/cdemu-daemon-${PV}

src_prepare() {
	if ! use pulseaudio; then
		sed -e 's:AUDIO_DRIVER=pulse:AUDIO_DRIVER=alsa:' \
			-i session/cdemu-daemon-session.sh || die "sed failed"
	fi
}

pkg_postinst() {
	elog "You will need to load the vhba module to use cdemu devices:"
	elog " # modprobe vhba"
	elog "To automatically load the vhba module at boot time, edit your"
	elog "/etc/conf.d/modules file."

	if [[ -e "${ROOT}etc/conf.d/cdemud" ]]; then
		elog
		elog "${PN} no longer installs an init.d service; instead, it is"
		elog "automatically activated when needed via dbus."
		elog "You can therefore remove ${ROOT}etc/conf.d/cdemud"
	fi
}
