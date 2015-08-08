# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.3.4.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_PN="hS3"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Interface to Amazon's Simple Storage Service (S3)"
HOMEPAGE="http://gregheartsfield.com/hS3/"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/crypto-4.1.0:=[profile?]
	dev-haskell/dataenc:=[profile?]
	>=dev-haskell/http-4000.0.0:=[profile?]
	>=dev-haskell/hxt-9.0.0:=[profile?] <dev-haskell/hxt-10:=[profile?]
	>=dev-haskell/missingh-0.18.6:=[profile?]
	dev-haskell/network:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/regex-compat:=[profile?]
	dev-haskell/utf8-string:=[profile?]
	>=dev-lang/ghc-6.10.4:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6.0.3
"

S="${WORKDIR}/${MY_P}"
