# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/alot/alot-0.3.ebuild,v 1.2 2012/03/25 08:33:46 aidecoe Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[456] 3.*"

inherit distutils vcs-snapshot versionator

MY_PV=$(replace_version_separator 2 '')
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Experimental terminal UI for net-mail/notmuch written in Python"
HOMEPAGE="https://github.com/pazz/alot"
SRC_URI="${HOMEPAGE}/tarball/${MY_PV} -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	>=dev-python/configobj-4.6.0
	>=dev-python/twisted-10.2.0
	>=dev-python/urwid-1.0.0
	net-mail/mailbase
	>=net-mail/notmuch-0.12[crypt,python]
	sys-apps/file[python]
	"

src_prepare() {
	distutils_src_prepare

	local md
	for md in *.md; do
		mv "${md}" "${md%.md}"
	done
}

pkg_postinst() {
	ewarn "Versioning scheme has been corrected.  Previous 0.21 is 0.2.1 now."
	echo
	ewarn "If you're upgrading from version prior to 0.3, you need to remove"
	ewarn "current config (\$HOME/.config/alot/config) before running alot,"
	ewarn "because its format has been changed."
}
