# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# ebuild generated by hackport 0.2.13

EAPI=4

#nocabaldep is for the fancy cabal-detection feature at build-time
CABAL_FEATURES="lib profile haddock hscolour hoogle nocabaldep"
inherit haskell-cabal

DESCRIPTION="Binding to the GIO"
HOMEPAGE="http://projects.haskell.org/gtk2hs/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="=dev-haskell/glib-0.12*:0[profile?]
		dev-haskell/mtl[profile?]
		>=dev-lang/ghc-6.10.1
		dev-libs/glib:2"
DEPEND="${RDEPEND}
		dev-haskell/gtk2hs-buildtools:0"

src_prepare() {
	# c2hs ignores #if __GLASGOW_HASKELL__ >= 706
	# I do not know which earlier ghc versions the patch submitted upstream works with
	if has_version ">=dev-lang/ghc-7.6.1"; then
		epatch "${FILESDIR}/${PN}-0.12.3-ghc-7.6.patch"
	fi
}
