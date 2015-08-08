# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.3.6.9999
#hackport: flags: +base4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Replaces/Enhances Text.Regex"
HOMEPAGE="http://hackage.haskell.org/package/regex-tdfa"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-haskell/mtl:=[profile?]
	dev-haskell/parsec:=[profile?]
	>=dev-haskell/regex-base-0.93.1:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.2.3
"

src_prepare() {
	# too much load on compiler (~2GB RAM against ~500)
	cabal_chdeps \
		'-O2 ' ' '
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=base4
}
