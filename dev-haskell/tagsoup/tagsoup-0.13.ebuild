# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.3.3.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Parsing and extracting information from (possibly malformed) HTML/XML documents"
HOMEPAGE="http://community.haskell.org/~ndm/tagsoup/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 x86"
IUSE="download"

RDEPEND="dev-haskell/text:=[profile?]
		>=dev-lang/ghc-6.10.4:=
		download? ( dev-haskell/network:=[profile?]
		)"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag download download)
}
