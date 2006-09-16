# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Time-HiRes/Time-HiRes-1.86.ebuild,v 1.8 2006/09/16 22:13:45 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Perl Time::HiRes. High resolution alarm, sleep, gettimeofday, interval timers"
HOMEPAGE="http://search.cpan.org/author/JHI/${P}/"
SRC_URI="mirror://cpan/authors/id/J/JH/JHI/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 m68k mips ppc ~ppc64 s390 sh sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

mydoc="TODO"

SRC_TEST="do"
