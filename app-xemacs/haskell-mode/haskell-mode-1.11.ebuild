# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/haskell-mode/haskell-mode-1.11.ebuild,v 1.5 2008/04/30 15:58:59 nixnut Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Haskell editing support."
PKG_CAT="standard"

RDEPEND="app-xemacs/dired
app-xemacs/mail-lib
app-xemacs/xemacs-base
app-xemacs/edit-utils
"
KEYWORDS="~alpha amd64 ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages
