# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.3.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Provides some basic WAI handlers and middleware"
HOMEPAGE="http://github.com/yesodweb/wai"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/ansi-terminal:=[profile?]
	dev-haskell/base64-bytestring:=[profile?]
	>=dev-haskell/blaze-builder-0.2.1.4:=[profile?] <dev-haskell/blaze-builder-0.4:=[profile?]
	>=dev-haskell/case-insensitive-0.2:=[profile?]
	dev-haskell/data-default-class:=[profile?]
	>=dev-haskell/fast-logger-2.1:=[profile?] <dev-haskell/fast-logger-2.3:=[profile?]
	>=dev-haskell/http-types-0.7:=[profile?]
	>=dev-haskell/lifted-base-0.1.2:=[profile?]
	>=dev-haskell/network-2.2.1.5:=[profile?]
	>=dev-haskell/resourcet-0.4.6:=[profile?] <dev-haskell/resourcet-1.2:=[profile?]
	dev-haskell/streaming-commons:=[profile?]
	>=dev-haskell/stringsearch-0.3:=[profile?] <dev-haskell/stringsearch-0.4:=[profile?]
	>=dev-haskell/text-0.7:=[profile?]
	>=dev-haskell/transformers-0.2.2:=[profile?]
	>=dev-haskell/void-0.5:=[profile?]
	>=dev-haskell/wai-3.0:=[profile?] <dev-haskell/wai-3.1:=[profile?]
	>=dev-haskell/wai-logger-2.0:=[profile?] <dev-haskell/wai-logger-2.3:=[profile?]
	dev-haskell/word8:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( dev-haskell/data-default
		>=dev-haskell/hspec-1.3
		dev-haskell/hunit
		dev-haskell/zlib )
"
