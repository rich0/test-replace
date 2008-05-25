# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/x11/x11-1.4.1.ebuild,v 1.2 2008/05/25 11:14:18 kolmodin Exp $

CABAL_FEATURES="lib profile haddock"
CABAL_MIN_VERSION=1.2.3.0
inherit haskell-cabal eutils autotools

MY_PN="X11"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A binding to the X11 graphics library"
HOMEPAGE="http://darcs.haskell.org/X11"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="xinerama"

DEPEND=">=dev-lang/ghc-6.4.2
		x11-libs/libX11
		xinerama? ( x11-libs/libXinerama )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack $A

	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.4.2-with-xinerama.patch"
	eautoreconf
}

src_compile() {
	CABAL_CONFIGURE_FLAGS="--configure-option=$(use_with xinerama)"
	cabal_src_compile
}
