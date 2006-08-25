# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xanim/xanim-2.80.1-r4.ebuild,v 1.34 2006/08/25 06:13:58 vapier Exp $

inherit flag-o-matic toolchain-funcs

DESCRIPTION="program for playing a wide variety of animation, audio and video formats"
HOMEPAGE="http://xanim.polter.net/"

LICENSE="XAnim"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="|| ( ( x11-libs/libXext
			x11-libs/libXt
		)
		virtual/x11
	)
	>=sys-libs/zlib-1.1.3"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.5
	|| ( x11-proto/xextproto virtual/x11 )"

MY_P=${PN}${PV//.}
S=${WORKDIR}/${MY_P}

_XA_CYUV_alpha=xa1.0_cyuv_linuxAlpha.o
_XA_CVID_alpha=xa2.0_cvid_linuxAlpha.o
_XA_IV32_alpha=xa2.0_iv32_linuxAlpha.o
_XA_EXT_alpha=.gz

_XA_CYUV_ppc=xa1.0_cyuv_linuxPPC.o
_XA_CVID_ppc=xa2.0_cvid_linuxPPC.o
_XA_IV32_ppc=xa2.0_iv32_linuxPPC.o
_XA_EXT_ppc=.Z

_XA_CYUV_sparc=xa1.0_cyuv_sparcELF.o
_XA_CVID_sparc=xa2.0_cvid_sparcELF.o
_XA_IV32_sparc=xa2.0_iv32_sparcELF.o
_XA_EXT_sparc=.Z

_XA_CYUV_x86=xa1.0_cyuv_linuxELFg21.o
_XA_CVID_x86=xa2.0_cvid_linuxELFg21.o
_XA_IV32_x86=xa2.1_iv32_linuxELFg21.o
_XA_EXT_x86=.gz

# This might leave _XA_EXT empty and that's fine, just indicates no
# particular support for a given arch
eval _XA_EXT=\${_XA_EXT_${ARCH}}
eval _XA_CVID=\${_XA_CVID_${ARCH}}
eval _XA_CYUV=\${_XA_CYUV_${ARCH}}
eval _XA_IV32=\${_XA_IV32_${ARCH}}

SRC_URI="mirror://gentoo/${MY_P}.tar.gz
	sparc? (
		mirror://gentoo/${_XA_CVID_sparc}${_XA_EXT_sparc}
		mirror://gentoo/${_XA_CYUV_sparc}${_XA_EXT_sparc}
		mirror://gentoo/${_XA_IV32_sparc}${_XA_EXT_sparc}
	)
	alpha? (
		mirror://gentoo/${_XA_CVID_alpha}${_XA_EXT_alpha}
		mirror://gentoo/${_XA_CYUV_alpha}${_XA_EXT_alpha}
		mirror://gentoo/${_XA_IV32_alpha}${_XA_EXT_alpha}
	)
	ppc? (
		mirror://gentoo/${_XA_CVID_ppc}${_XA_EXT_ppc}
		mirror://gentoo/${_XA_CYUV_ppc}${_XA_EXT_ppc}
		mirror://gentoo/${_XA_IV32_ppc}${_XA_EXT_ppc}
	)
	x86? (
		mirror://gentoo/${_XA_CVID_x86}${_XA_EXT_x86}
		mirror://gentoo/${_XA_CYUV_x86}${_XA_EXT_x86}
		mirror://gentoo/${_XA_IV32_x86}${_XA_EXT_x86}
	)"


src_unpack() {
	unpack ${MY_P}.tar.gz
	if [[ -n ${_XA_EXT} ]]; then
		mkdir "${S}"/mods || die
		cd "${S}"/mods || die
		unpack ${_XA_CVID}${_XA_EXT}
		unpack ${_XA_CYUV}${_XA_EXT}
		unpack ${_XA_IV32}${_XA_EXT}
	fi
	cd "${S}"
	sed -i -e 's:/usr/X11R6:/usr:g' Makefile*

	epatch "${FILESDIR}/${P}-gcc41.patch"
}

src_compile() {
	# -O higher than -O2 breaks for GCC3.1
	replace-flags -O3 -O2
	filter-flags -finline-functions

	# Set XA_DLL_PATH even though we statically link the mods, I guess
	# this provides extensibility
	make CC="$(tc-getCC)" OPTIMIZE="${CFLAGS}" \
		XA_DLL_DEF="-DXA_DLL -DXA_PRINT" XA_DLL_PATH=/usr/lib/xanim/mods \
		${_XA_EXT:+ \
			XA_IV32_LIB="mods/${_XA_CVID}" \
			XA_CYUV_LIB="mods/${_XA_CYUV}" \
			XA_CVID_LIB="mods/${_XA_IV32}" } \
		|| die
}

src_install() {
	dobin xanim || die
	newman docs/xanim.man xanim.1
	dodoc README
	dodoc docs/README.* docs/*.readme docs/*.doc

	# I don't know why we're installing these modules when they're
	# statically linked, but whatever...
	if [[ -n ${_XA_EXT} ]]; then
		insinto /usr/lib/xanim/mods
		doins mods/${_XA_CVID}
		doins mods/${_XA_CYUV}
		doins mods/${_XA_IV32}
	fi
}
