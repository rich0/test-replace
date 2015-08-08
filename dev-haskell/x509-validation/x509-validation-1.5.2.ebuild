# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="X.509 Certificate and CRL validation"
HOMEPAGE="http://github.com/vincenthz/hs-certificate"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/asn1-encoding-0.9:=[profile?] <dev-haskell/asn1-encoding-0.10:=[profile?]
	>=dev-haskell/asn1-types-0.3:=[profile?] <dev-haskell/asn1-types-0.4:=[profile?]
	dev-haskell/byteable:=[profile?]
	>=dev-haskell/crypto-pubkey-0.1.4:=[profile?] <dev-haskell/crypto-pubkey-0.3:=[profile?]
	>=dev-haskell/crypto-pubkey-types-0.4:=[profile?] <dev-haskell/crypto-pubkey-types-0.5:=[profile?]
	>=dev-haskell/cryptohash-0.9:=[profile?] <dev-haskell/cryptohash-0.12:=[profile?]
	dev-haskell/data-default-class:=[profile?]
	dev-haskell/hourglass:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/network:=[profile?]
	>=dev-haskell/pem-0.1:=[profile?] <dev-haskell/pem-0.3:=[profile?]
	>=dev-haskell/x509-1.5.0:=[profile?] <dev-haskell/x509-1.6:=[profile?]
	>=dev-haskell/x509-store-1.5:=[profile?] <dev-haskell/x509-store-1.6:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"
