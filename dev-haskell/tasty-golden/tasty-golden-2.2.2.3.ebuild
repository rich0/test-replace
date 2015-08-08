# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit base haskell-cabal

DESCRIPTION="Golden tests support for tasty"
HOMEPAGE="https://github.com/feuerbach/tasty-golden"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/mtl:=[profile?]
	dev-haskell/optparse-applicative:=[profile?]
	dev-haskell/tagged:=[profile?]
	>=dev-haskell/tasty-0.8:=[profile?]
	dev-haskell/temporary-rc:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.14
	test? ( dev-haskell/tasty-hunit )
"

PATCHES=("${FILESDIR}"/${PN}-2.2.1-haddock.patch)
