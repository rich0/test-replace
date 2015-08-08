# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="An either monad transformer"
HOMEPAGE="http://github.com/ekmett/either/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/bifunctors-4:=[profile?] <dev-haskell/bifunctors-6:=[profile?]
	>=dev-haskell/exceptions-0.5:=[profile?] <dev-haskell/exceptions-0.9:=[profile?]
	>=dev-haskell/free-4.9:=[profile?] <dev-haskell/free-5:=[profile?]
	>=dev-haskell/mmorph-1.0.0:=[profile?] <dev-haskell/mmorph-1.1:=[profile?]
	>=dev-haskell/monad-control-0.3.2:=[profile?] <dev-haskell/monad-control-1.1:=[profile?]
	>=dev-haskell/monadrandom-0.1:=[profile?] <dev-haskell/monadrandom-0.5:=[profile?]
	>=dev-haskell/mtl-2.0:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/profunctors-4:=[profile?] <dev-haskell/profunctors-6:=[profile?]
	>=dev-haskell/semigroupoids-4:=[profile?] <dev-haskell/semigroupoids-6:=[profile?]
	>=dev-haskell/semigroups-0.8.3.1:=[profile?] <dev-haskell/semigroups-1:=[profile?]
	>=dev-haskell/transformers-0.2:=[profile?] <dev-haskell/transformers-0.5:=[profile?]
	>=dev-haskell/transformers-base-0.4:=[profile?] <dev-haskell/transformers-base-0.5:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"
