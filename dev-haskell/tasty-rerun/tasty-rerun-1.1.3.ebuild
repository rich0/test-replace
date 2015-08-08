# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Run tests by filtering the test tree depending on the result of previous test runs"
HOMEPAGE="http://github.com/ocharles/tasty-rerun"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/mtl-2.1.2:=[profile?]
	>=dev-haskell/optparse-applicative-0.6:=[profile?]
	>=dev-haskell/reducers-3.10.1:=[profile?]
	>=dev-haskell/split-0.1:=[profile?] <dev-haskell/split-0.3:=[profile?]
	>=dev-haskell/stm-2.4.2:=[profile?]
	>=dev-haskell/tagged-0.7:=[profile?] <dev-haskell/tagged-0.8:=[profile?]
	>=dev-haskell/tasty-0.10:=[profile?] <dev-haskell/tasty-0.11:=[profile?]
	>=dev-haskell/transformers-0.3.0.0:=[profile?]
	>=dev-lang/ghc-7.6.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.16.0
"

src_prepare() {
	cabal_chdeps \
		'base >=4.6 && <4.8' 'base >=4.6'
	sed -e 's@LANGUAGE @LANGUAGE FlexibleContexts, @' \
		-i "${S}/src/Test/Tasty/Ingredients/Rerun.hs" || die
}
