# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/FileHandle-Unget/FileHandle-Unget-0.14.ebuild,v 1.8 2005/04/25 16:23:39 mcummings Exp $

inherit perl-module

DESCRIPTION="A FileHandle which supports ungetting of multiple bytes"
SRC_URI="mirror://cpan/authors/id/D/DC/DCOPPIT/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/DCOPPIT/${P}.readme"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc amd64"
IUSE=""

DEPEND="dev-perl/WeakRef"
