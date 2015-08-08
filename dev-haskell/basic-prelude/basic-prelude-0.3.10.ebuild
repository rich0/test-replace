# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="An enhanced core prelude; a common foundation for alternate preludes"
HOMEPAGE="https://github.com/snoyberg/basic-prelude"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/hashable:=[profile?]
	dev-haskell/lifted-base:=[profile?]
	>=dev-haskell/readargs-1.2:=[profile?] <dev-haskell/readargs-1.3:=[profile?]
	dev-haskell/safe:=[profile?]
	>=dev-haskell/system-filepath-0.4:=[profile?] <dev-haskell/system-filepath-0.5:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/transformers:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
"
