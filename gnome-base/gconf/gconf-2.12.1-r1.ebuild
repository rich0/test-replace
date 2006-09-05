# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gconf/gconf-2.12.1-r1.ebuild,v 1.5 2006/09/05 01:58:52 kumba Exp $

inherit gnome2 eutils

MY_PN=GConf
MY_P=${MY_PN}-${PV}
PVP=(${PV//[-\._]/ })
S=${WORKDIR}/${MY_P}

DESCRIPTION="Gnome Configuration System and Daemon"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.7
	>=gnome-base/orbit-2.4
	>=dev-libs/libxml2-2
	dev-libs/popt
	>=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1 )"

# FIXME : consider merging the tree (?)

DOCS="ABOUT-NLS AUTHORS ChangeLog NEWS README TODO"
USE_DESTDIR="1"
MAKEOPTS="${MAKEOPTS} -j1"


pkg_setup() {
	G2CONF="--enable-gtk"
	kill_gconf
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch to prevent stomping of the last character (bug #120398)
	epatch ${FILESDIR}/gconf-2.12.1-gconf_unescape_key.patch
}

src_install() {
	gnome2_src_install

	# hack hack
	dodir /etc/gconf/gconf.xml.mandatory
	dodir /etc/gconf/gconf.xml.defaults
	touch ${D}/etc/gconf/gconf.xml.mandatory/.keep${SLOT}
	touch ${D}/etc/gconf/gconf.xml.defaults/.keep${SLOT}

	dodir /etc/env.d
	dodir /root/.gconfd
}

kill_gconf() {
	# this function will kill all running gconfd that could be causing troubles
	if [ -x /usr/bin/gconftool ]
	then
		/usr/bin/gconftool --shutdown
	fi
	if [ -x /usr/bin/gconftool-1 ]
	then
		/usr/bin/gconftool-1 --shutdown
	fi

	# and for gconf 2
	if [ -x /usr/bin/gconftool-2 ]
	then
		/usr/bin/gconftool-2 --shutdown
	fi
	return 0
}

pkg_preinst() {
	kill_gconf

	echo 'CONFIG_PROTECT_MASK="/etc/gconf"' > ${IMAGE}/etc/env.d/50gconf
}

pkg_postinst() {
	kill_gconf

	#change the permissions to avoid some gconf bugs
	einfo "changing permissions for gconf dirs"
	find  /etc/gconf/ -type d -exec chmod ugo+rx "{}" \;
	einfo "changing permissions for gconf files"
	find  /etc/gconf/ -type f -exec chmod ugo+r "{}" \;
}
