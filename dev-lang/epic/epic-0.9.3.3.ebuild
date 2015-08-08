# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit eutils haskell-cabal

DESCRIPTION="Compiler for a simple functional language"
HOMEPAGE="http://www.dcs.st-and.ac.uk/~eb/epic.php"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/cabal:=[profile?]
	dev-haskell/mtl:=[profile?]
	>=dev-libs/boehm-gc-7.0[threads]
	dev-libs/gmp:0
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8.0.4
"

src_prepare() {
	# Bug #438422, upstream at https://github.com/edwinb/EpiVM/issues/5.
	epatch "${FILESDIR}"/respect-user-cflags.patch
}
