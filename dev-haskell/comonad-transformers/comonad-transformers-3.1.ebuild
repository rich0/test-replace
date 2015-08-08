# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Comonad transformers"
HOMEPAGE="http://github.com/ekmett/comonad-transformers/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/comonad-3.0:=[profile?]
		>=dev-haskell/contravariant-0.2.0.1:=[profile?]
		>=dev-haskell/distributive-0.2.2:=[profile?]
		>=dev-haskell/semigroupoids-3.0:=[profile?]
		>=dev-haskell/semigroups-0.8.3.1:=[profile?]
		>=dev-haskell/transformers-0.2:=[profile?]
		<dev-haskell/transformers-0.4:=[profile?]
		>=dev-lang/ghc-6.12.1:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
