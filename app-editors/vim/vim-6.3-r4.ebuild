# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim/vim-6.3-r4.ebuild,v 1.1 2005/01/21 22:29:57 ciaranm Exp $

inherit vim

VIM_VERSION="6.3"
VIM_ORG_PATCHES="vim-6.3.058-patches.tar.bz2"
VIM_GENTOO_PATCHES="vim-6.3.058-gentoo-patches.tar.bz2"

SRC_URI="${SRC_URI}
	ftp://ftp.vim.org/pub/vim/unix/vim-${VIM_VERSION}.tar.bz2
	nls? ( ftp://ftp.vim.org/pub/vim/extra/vim-${VIM_VERSION}-lang.tar.gz )
	mirror://gentoo/${VIM_GENTOO_PATCHES}
	mirror://gentoo/${VIM_ORG_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.}
DESCRIPTION="Vim, an improved vi-style text editor"
KEYWORDS="~x86 ~sparc ~mips ~ppc ~amd64 ~alpha ~ia64 ~arm ~hppa ~ppc64 ~s390"
IUSE="${IUSE} nls"
PROVIDE="virtual/editor"
DEPEND="${DEPEND}
	~app-editors/vim-core-${PV}"
