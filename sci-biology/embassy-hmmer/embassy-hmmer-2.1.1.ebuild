# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-hmmer/embassy-hmmer-2.1.1.ebuild,v 1.1 2004/12/23 23:00:55 ribosome Exp $

inherit embassy

DESCRIPTION="EMBOSS integrated version of HMMER - Biological sequence analysis with profile HMMs"

KEYWORDS="x86 ~ppc"

src_install() {
	embassy_src_install
	insinto /usr/include/emboss/hmmer
	doins src/*.h
}
