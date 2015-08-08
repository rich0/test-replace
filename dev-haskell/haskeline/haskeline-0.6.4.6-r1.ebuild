# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# ebuild generated by hackport 0.2.14

EAPI="4"

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A command-line interface for user input, written in Haskell"
HOMEPAGE="http://trac.haskell.org/haskeline"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="<dev-haskell/mtl-2.2[profile?]
		>=dev-haskell/terminfo-0.3.1.3[profile?]
		<dev-haskell/utf8-string-0.4[profile?]
		>=dev-lang/ghc-6.10.4"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	sed -e 's@mtl >= 1.1 && < 2.1@mtl >= 1.1 \&\& < 2.2@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen dependencies"
}
