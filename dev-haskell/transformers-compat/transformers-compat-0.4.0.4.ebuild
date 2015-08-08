# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.4.9999
#hackport: flags: -two,+mtl

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A small compatibility shim for dev-haskell/transformers"
HOMEPAGE="http://github.com/ekmett/transformers-compat/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="three"

RDEPEND=">=dev-lang/ghc-7.4.1:=
	three? ( >=dev-haskell/mtl-2.1:=[profile?] <dev-haskell/mtl-2.2:=[profile?]
			>=dev-haskell/transformers-0.3:=[profile?] <dev-haskell/transformers-0.4:=[profile?] )
	!three? ( >=dev-haskell/transformers-0.4.1:=[profile?] <dev-haskell/transformers-0.5:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=mtl \
		$(cabal_flag three three) \
		--flag=-two
}
