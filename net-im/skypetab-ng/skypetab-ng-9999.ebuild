# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skypetab-ng/skypetab-ng-9999.ebuild,v 1.3 2012/06/09 14:28:03 slyfox Exp $

EAPI=4

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://github.com/kekekeks/skypetab-ng.git"
	UNPACKER_ECLASS="git-2"
	LIVE_EBUILD=yes
else
	UNPACKER_ECLASS="vcs-snapshot"
fi

inherit qt4-r2 multilib ${UNPACKER_ECLASS}

if [[ -z ${LIVE_EBUILD} ]]; then
	KEYWORDS="-* ~x86 ~amd64"
	SRC_URI="http://github.com/kekekeks/${PN}/tarball/v${PV} -> ${P}.tar.gz"
fi

DESCRIPTION="An LD_PRELOAD wrapper that adds tabs to Skype for Linux"
HOMEPAGE="http://github.com/kekekeks/skypetab-ng"
LICENSE="LGPL-3"
SLOT="0"
IUSE=""

DEPEND="
	x11-libs/qt-gui
	amd64? ( app-emulation/emul-linux-x86-qtlibs )
"
RDEPEND="${DEPEND}
	net-im/skype[-qt-static]
"

pkg_setup() {
	use amd64 && multilib_toolchain_setup x86
}
