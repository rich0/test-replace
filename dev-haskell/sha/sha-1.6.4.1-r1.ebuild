# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.4.9999
#hackport: flags: +decoderinterface

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_PN="SHA"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Implementations of the SHA suite of message digest functions"
HOMEPAGE="http://hackage.haskell.org/package/SHA"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="exe test"

RDEPEND=">=dev-haskell/binary-0.7:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( >=dev-haskell/quickcheck-2.5:2=[profile?] <dev-haskell/quickcheck-3:2=[profile?]
		>=dev-haskell/test-framework-0.8.0.3:=[profile?]
		>=dev-haskell/test-framework-quickcheck2-0.3.0.2:=[profile?] )
"

S="${WORKDIR}/${MY_P}"

src_configure() {
	haskell-cabal_src_configure \
		--flag=decoderinterface \
		$(cabal_flag exe exe) \
		$(cabal_flag test test)
}

src_test() {
	# This package builds a test executable called test_sha, but the
	# suite isn't integrated with cabal yet. It's fixed upstream in git.
	dist/build/test_sha/test_sha || die "test suite failed"
}
