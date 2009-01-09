# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Image-Imlib2/Image-Imlib2-1.13.ebuild,v 1.8 2009/01/09 17:52:48 tove Exp $

MODULE_AUTHOR=LBROCARD
inherit perl-module

DESCRIPTION="Interface to the Imlib2 image library"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND=">=media-libs/imlib2-1
	dev-lang/perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	virtual/perl-ExtUtils-CBuilder"
