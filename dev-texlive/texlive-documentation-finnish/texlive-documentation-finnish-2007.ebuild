# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-finnish/texlive-documentation-finnish-2007.ebuild,v 1.15 2008/05/12 19:14:21 nixnut Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="lshort-finnish collection-documentation-finnish
"
inherit texlive-module
DESCRIPTION="TeXLive Finnish documentation"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
