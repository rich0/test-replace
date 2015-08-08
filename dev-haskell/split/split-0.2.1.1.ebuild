# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.3.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Combinator library for splitting lists"
HOMEPAGE="http://hackage.haskell.org/package/split"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		test? ( >=dev-haskell/quickcheck-2.4
		)
		>=dev-haskell/cabal-1.10"

src_prepare() {
	cabal_chdeps \
		'base <4.7' 'base <5.0'
}
