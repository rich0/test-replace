# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

XORG_MODULE=/
XORG_BASE_INDIVIDUAL_URI=http://xcb.freedesktop.org/dist
XORG_DOC=doc
inherit xorg-2

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xcb/util-image"
EGIT_HAS_SUBMODULES=yes

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="http://xcb.freedesktop.org/"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris"
IUSE="test"

RDEPEND=">=x11-libs/xcb-util-${PV}
	x11-proto/xproto"
DEPEND="${RDEPEND}
	>=dev-util/gperf-3.0.1
	test? ( >=dev-libs/check-0.9.4 )"

PATCHES=(
	"${FILESDIR}"/${P}-return-type.patch
)

pkg_setup() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_with doc doxygen)
	)

	xorg-2_pkg_setup
}
