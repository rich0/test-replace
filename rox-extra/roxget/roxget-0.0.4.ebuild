# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/roxget/roxget-0.0.4.ebuild,v 1.2 2005/02/10 19:20:52 sergey Exp $

DESCRIPTION="ROXget - Download Handler for the ROX Desktop"

MY_PN="ROXget"

MY_PV="004"

HOMEPAGE="http://nipul.digitillogic.net/"

SRC_URI="http://nipul.digitillogic.net/${MY_PN}-${MY_PV}.tar.bz2"

LICENSE="MIT"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="dev-python/urlgrabber"

ROX_LIB_VER=1.9.16

APPNAME=${MY_PN}

S=${WORKDIR}/${MY_PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd ${MY_PN}-${MY_PV}
	mkdir ${APPNAME}
	mv * ${APPNAME}/
}

inherit rox
