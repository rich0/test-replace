# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_P=${PN}-src-${PV}
inherit eutils multilib toolchain-funcs

DESCRIPTION="A fork of Mupen64 Nintendo 64 emulator, HLE RSP plugin"
HOMEPAGE="http://code.google.com/p/mupen64plus/"
SRC_URI="https://github.com/mupen64plus/${PN}/releases/download/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=games-emulation/mupen64plus-core-2.0-r1:0="
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch_user

	# avoid implicitly appending CPU flags
	sed -i -e 's:-mmmx::g' -e 's:-msse::g' projects/unix/Makefile || die
}

src_compile() {
	MAKEARGS=(
		# Note: please keep this in sync in all of mupen64plus-* packages

		-C projects/unix

		# this basically means: GNU userspace
		UNAME=Linux

		# verbose output
		V=1

		CROSS_COMPILE="${CHOST}-"
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		PKG_CONFIG="$(tc-getPKG_CONFIG)"
		# usual CFLAGS, CXXFLAGS and LDFLAGS are respected
		# so we can leave OPTFLAGS empty
		OPTFLAGS=

		# paths, some of them are used at compile time
		PREFIX=/usr
		LIBDIR=/usr/$(get_libdir)

		# disable unwanted magic
		LDCONFIG=:
		INSTALL_STRIP_FLAG=
	)

	use amd64 && MAKEARGS+=( HOST_CPU=x86_64 )
	use x86 && MAKEARGS+=( HOST_CPU=i386 )

	emake "${MAKEARGS[@]}" all
}

src_install() {
	emake "${MAKEARGS[@]}" DESTDIR="${D}" install
	einstalldocs
}
