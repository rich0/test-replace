# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

# ebuild generated by hackport 0.2.18.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_PN="OpenAL"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A binding to the OpenAL cross-platform 3D audio API"
HOMEPAGE="http://connect.creativelabs.com/openal/"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/objectname[profile?]
		dev-haskell/statevar[profile?]
		dev-haskell/tensor[profile?]
		>=dev-lang/ghc-6.8.2
		media-libs/openal"
DEPEND="${RDEPEND}
		dev-haskell/cabal"

S="${WORKDIR}/${MY_P}"
