# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="SmallCheck support for the Tasty test framework"
HOMEPAGE="https://github.com/feuerbach/tasty"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND="dev-haskell/async:=[profile?]
		>=dev-haskell/smallcheck-1.0:=[profile?]
		dev-haskell/tagged:=[profile?]
		dev-haskell/tasty:=[profile?]
		>=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
