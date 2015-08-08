# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="3"

inherit cmake-utils subversion

DESCRIPTION="Command line interface for OpenSync"
HOMEPAGE="http://www.opensync.org/"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/osynctool/trunk"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="~app-pda/libopensync-${PV}
	dev-libs/glib:2
	!app-pda/msynctool"
DEPEND="${DEPEND}"

DOCS="AUTHORS CODING"

src_prepare() {
	sed -i -e 's:/etc/bash_completion.d:/share/bash-completion:g' \
		tools/CMakeLists.txt
}
