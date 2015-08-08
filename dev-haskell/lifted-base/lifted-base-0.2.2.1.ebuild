# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.3.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="lifted IO operations from the base library"
HOMEPAGE="https://github.com/basvandijk/lifted-base"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

RDEPEND=">=dev-haskell/base-unicode-symbols-0.1.1:=[profile?] <dev-haskell/base-unicode-symbols-0.3:=[profile?]
	>=dev-haskell/monad-control-0.3:=[profile?] <dev-haskell/monad-control-0.4:=[profile?]
	>=dev-haskell/transformers-base-0.4:=[profile?] <dev-haskell/transformers-base-0.5:=[profile?]
	>=dev-lang/ghc-6.10.4:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( >=dev-haskell/hunit-1.2.2 <dev-haskell/hunit-1.3
		>=dev-haskell/test-framework-0.2.4 <dev-haskell/test-framework-0.9
		>=dev-haskell/test-framework-hunit-0.2.4 <dev-haskell/test-framework-hunit-0.4
		>=dev-haskell/transformers-0.2 <dev-haskell/transformers-0.4 )
"
