# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim-core/vim-core-7.1_beta001.ebuild,v 1.1 2007/05/10 07:18:39 pioto Exp $

inherit vim

VIM_VERSION="7.1a"
VIM_GENTOO_PATCHES="vim-${VIM_VERSION}-gentoo-patches.tar.bz2"
VIM_ORG_PATCHES="vim-patches-${PV}.tar.gz"
VIMRC_FILE_SUFFIX="-r3"

SRC_URI="ftp://ftp.vim.org/pub/vim/unstable/unix/vim-${VIM_VERSION}.tar.bz2
	mirror://gentoo/${VIM_ORG_PATCHES}
	mirror://gentoo/${VIM_GENTOO_PATCHES}"

S="${WORKDIR}/vim${VIM_VERSION/.}"
DESCRIPTION="vim and gvim shared files"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""
DEPEND="${DEPEND}"
PDEPEND="!livecd? ( app-vim/gentoo-syntax )"
