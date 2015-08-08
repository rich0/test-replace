# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.3

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="integration testing for WAI/Yesod Applications"
HOMEPAGE="http://www.yesodweb.com"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/attoparsec-0.10:=[profile?]
	dev-haskell/blaze-builder:=[profile?]
	>=dev-haskell/blaze-html-0.5:=[profile?]
	>=dev-haskell/blaze-markup-0.5.1:=[profile?]
	>=dev-haskell/case-insensitive-0.2:=[profile?]
	dev-haskell/cookie:=[profile?]
	>=dev-haskell/hspec-core-2:=[profile?] <dev-haskell/hspec-core-3:=[profile?]
	>=dev-haskell/html-conduit-0.1:=[profile?]
	>=dev-haskell/http-types-0.7:=[profile?]
	>=dev-haskell/hunit-1.2:=[profile?]
	dev-haskell/monad-control:=[profile?]
	>=dev-haskell/network-2.2:=[profile?]
	>=dev-haskell/persistent-1.0:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-haskell/transformers-0.2.2:=[profile?]
	>=dev-haskell/wai-3.0:=[profile?]
	dev-haskell/wai-extra:=[profile?]
	>=dev-haskell/xml-conduit-1.0:=[profile?]
	>=dev-haskell/xml-types-0.3:=[profile?]
	>=dev-haskell/yesod-core-1.4:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( dev-haskell/hspec
		dev-haskell/yesod-form )
"
