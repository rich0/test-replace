# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Special functions and Chebyshev polynomials"
HOMEPAGE="https://github.com/bos/math-functions"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/erf-2:=[profile?]
		>=dev-haskell/vector-0.7:=[profile?]
		>=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		test? ( >=dev-haskell/hunit-1.2
			>=dev-haskell/ieee754-0.7.3
			>=dev-haskell/quickcheck-2.4
			dev-haskell/test-framework
			dev-haskell/test-framework-hunit
			dev-haskell/test-framework-quickcheck2
		)
		>=dev-haskell/cabal-1.8"
