# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit base haskell-cabal

DESCRIPTION="A library for writing CGI programs"
HOMEPAGE="http://andersk.mit.edu/haskell/cgi/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="+extensible-exceptions-in-base"

RDEPEND="dev-haskell/monadcatchio-mtl:=[profile?]
		>=dev-haskell/mtl-1.0:=[profile?]
		>=dev-haskell/network-2.0:=[profile?]
		>=dev-haskell/parsec-2.0:=[profile?]
		>=dev-haskell/xhtml-3000.0.0:=[profile?]
		>=dev-lang/ghc-6.10.4:=
		!extensible-exceptions-in-base? ( dev-haskell/extensible-exceptions:=[profile?]
		)"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

PATCHES=("${FILESDIR}"/${P}-mci.patch)

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag extensible-exceptions-in-base extensible-exceptions-in-base)
}
