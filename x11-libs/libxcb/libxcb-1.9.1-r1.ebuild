# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3} )
PYTHON_REQ_USE=xml

XORG_DOC=doc
XORG_MULTILIB=yes
inherit eutils python-single-r1 xorg-2

DESCRIPTION="X C-language Bindings library"
HOMEPAGE="http://xcb.freedesktop.org/"
EGIT_REPO_URI="git://anongit.freedesktop.org/git/xcb/libxcb"
[[ ${PV} != 9999* ]] && \
	SRC_URI="http://xcb.freedesktop.org/dist/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="selinux xkb"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND=">=dev-libs/libpthread-stubs-0.3-r1[${MULTILIB_USEDEP}]
	>=x11-libs/libXau-1.0.7-r1[${MULTILIB_USEDEP}]
	>=x11-libs/libXdmcp-1.1.1-r1[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	dev-lang/python[xml]
	dev-libs/libxslt
	>=x11-proto/xcb-proto-1.9-r1[${MULTILIB_USEDEP},${PYTHON_USEDEP}]
	${PYTHON_DEPS}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	# https://bugs.gentoo.org/show_bug.cgi?id=472032
	sed -e 's@x$(HTML_CHECK_RESULT)@xfalse@' \
		-i "${S}/tests/Makefile.am" \
		-i "${S}/tests/Makefile.in" \
		|| die "Could not patch tests/Makefile.am and tests/Makefile.in to fix tests"
	# http://patchwork.freedesktop.org/patch/15185/
	# Sounds like this commit is missing:
	# c_client.py: Handle multiple expr. in a bitcase
	# http://cgit.freedesktop.org/xcb/libxcb/commit/?id=e602b65
	epatch "${FILESDIR}/${PN}-1.9.1-list-object-has-no-attribute-lenfield_name.patch"
	# https://bugs.freedesktop.org/show_bug.cgi?id=71502
	epatch "${FILESDIR}/${PN}-1.9.1-conflicting-types-for-xcb_ge_event_t.patch"
}

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable doc build-docs)
		$(use_enable selinux)
		$(use_enable xkb)
		--enable-xinput
	)
	xorg-2_src_configure
}
