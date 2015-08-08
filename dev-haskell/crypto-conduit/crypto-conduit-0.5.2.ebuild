# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Conduit interface for cryptographic operations (from crypto-api)"
HOMEPAGE="https://github.com/meteficha/crypto-conduit"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-haskell/cereal-0.3*:=[profile?]
		=dev-haskell/conduit-1.0*:=[profile?]
		>=dev-haskell/transformers-0.2:=[profile?]
		<dev-haskell/transformers-0.4:=[profile?]
		>=dev-lang/ghc-6.10.4:=
		<dev-haskell/crypto-api-0.13:=[profile?]
		>=dev-haskell/crypto-api-0.9:=[profile?]
		"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? ( >=dev-haskell/cryptocipher-0.4
			>=dev-haskell/cryptohash-cryptoapi-0.1
			>=dev-haskell/hspec-1.3
			>=dev-haskell/skein-0.1
		)"

# fails to build
#    Not in scope: `CM.incIV'
#    Perhaps you meant `C.incIV' (imported from Crypto.Classes)
RESTRICT=test
CABAL_EXTRA_CONFIGURE_FLAGS+=" --disable-tests"
