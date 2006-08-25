# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/cpphs/cpphs-1.2.ebuild,v 1.3 2006/08/25 15:58:58 fmccor Exp $

CABAL_FEATURES="bin lib profile"
inherit eutils haskell-cabal

DESCRIPTION="A liberalised cpp-a-like preprocessor for Haskell"
HOMEPAGE="http://haskell.org/cpphs/"
SRC_URI="http://www.cs.york.ac.uk/fp/cpphs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ppc64 sparc ~x86"
IUSE=""

DEPEND="virtual/ghc"

src_install() {
	cabal_src_install
	dohtml docs/index.html
	doman docs/cpphs.1
}
