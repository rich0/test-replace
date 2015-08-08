# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Modern and extensible testing framework"
HOMEPAGE="http://hackage.haskell.org/package/tasty"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="+colors"

RDEPEND="dev-haskell/mtl:=[profile?]
		>=dev-haskell/optparse-applicative-0.5:=[profile?]
		dev-haskell/regex-posix:=[profile?]
		dev-haskell/stm:=[profile?]
		dev-haskell/tagged:=[profile?]
		>=dev-lang/ghc-6.10.4:=
		colors? ( dev-haskell/ansi-terminal:=[profile?]
		)"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.10"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag colors colors)
}
