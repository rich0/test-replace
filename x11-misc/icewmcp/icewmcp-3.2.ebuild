# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icewmcp/icewmcp-3.2.ebuild,v 1.3 2004/09/29 08:33:34 pyrania Exp $

S=${WORKDIR}/INSTALL-IceWMCP
MY_PN=IceWMControlPanel
MY_DEST=usr/lib/${P}
MY_BIN=usr/bin

DESCRIPTION="A complete control panel for IceWM using gtk & python"
HOMEPAGE="http://icesoundmanager.sourceforge.net/index.php"
SRC_URI="mirror://sourceforge/icesoundmanager/${MY_PN}-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 ppc"
IUSE=""
DEPEND="x11-wm/icewm
		>=dev-python/pygtk-1.99
		>=x11-libs/gtk+-2.0.0
		>=dev-lang/python-2.2"

src_install() {
	dodir ${MY_DEST}/
	dodir ${MY_BIN}/
	dodoc ${S}/doc/* ${S}/licenses/*
	cp ${S}/* ${D}/${MY_DEST}
	cp -R ${S}/applets ${S}/applet-icons ${S}/help ${S}/icons ${S}/locale ${S}/pixmaps ${D}/${MY_DEST}/
	# create executable shortcuts to the python scripts
	echo -e "#!/bin/bash \n python /${MY_DEST}/IceWMCP.py" > ${T}/IceWMCP
	echo -e "#!/bin/bash \n python /${MY_DEST}/IceWMCPKeyboard.py" > ${T}/IceWMCP-Keyboard
	echo -e "#!/bin/bash \n python /${MY_DEST}/IceWMCPMouse.py" > ${T}/IceWMCP-Mouse
	echo -e "#!/bin/bash \n python /${MY_DEST}/pyspool.py" > ${T}/IceWMCP-PySpool
	echo -e "#!/bin/bash \n python /${MY_DEST}/IceWMCPWallpaper.py" > ${T}/IceWMCP-Wallpaper
	echo -e "#!/bin/bash \n python /${MY_DEST}/IceWMCPWinOptions.py" > ${T}/IceWMCP-WinOptions
	echo -e "#!/bin/bash \n python /${MY_DEST}/phrozenclock.py" > ${T}/PhrozenClock
	echo -e "#!/bin/bash \n python /${MY_DEST}/icesound.py" > ${T}/IceSoundManager
	echo -e "#!/bin/bash \n python /${MY_DEST}/IceWMCP_GtkPCCard.py" > ${T}/GtkPCCard
	echo -e "#!/bin/bash \n python /${MY_DEST}/IceMe.py" > ${T}/iceme
	echo -e "#!/bin/bash \n python /${MY_DEST}/icepref.py" > ${T}/icepref
	echo -e "#!/bin/bash \n python /${MY_DEST}/icepref_td.py" > ${T}/icepref_td
	echo -e "#!/bin/bash \n python /${MY_DEST}/IceWMCPGtkIconSelection.py" > ${T}/IceWMCP-Icons
	echo -e "#!/bin/bash \n python /${MY_DEST}/IceWMCPEnergyStar.py" > ${T}/IceWMCP-EnergyStar
	dobin ${T}/*
}

pkg_postinst() {
	einfo "Some of the icons displayed by IceWMCP may be pointing to"
	einfo "programs which are not on your system!  You can hide them"
	einfo "using the Configuration window (Ctrl+C) or change them"
	einfo "by editing the files in"
	einfo "/${MY_DEST}/applets and"
	einfo "/${MY_DEST}/applet-icons."
}
