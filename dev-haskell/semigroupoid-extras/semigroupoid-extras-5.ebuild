# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Semigroupoids that depend on PolyKinds"
HOMEPAGE="http://github.com/ekmett/semigroupoid-extras"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+profunctors"

RDEPEND=">=dev-haskell/semigroupoids-5:=[profile?] <dev-haskell/semigroupoids-6:=[profile?]
	>=dev-lang/ghc-7.6.1:=
	profunctors? ( >=dev-haskell/profunctors-5:=[profile?] <dev-haskell/profunctors-6:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.16.0
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag profunctors profunctors)
}
