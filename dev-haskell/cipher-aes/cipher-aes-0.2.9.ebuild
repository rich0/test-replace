# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Fast AES cipher implementation with advanced mode of operations"
HOMEPAGE="http://github.com/vincenthz/hs-cipher-aes"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/byteable:=[profile?]
	>=dev-haskell/crypto-cipher-types-0.0.6:=[profile?] <dev-haskell/crypto-cipher-types-0.1:=[profile?]
	>=dev-haskell/securemem-0.1.2:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( >=dev-haskell/crypto-cipher-tests-0.0.8
		>=dev-haskell/quickcheck-2
		>=dev-haskell/test-framework-0.3.3
		>=dev-haskell/test-framework-quickcheck2-0.2.9 )
"
