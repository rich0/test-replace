# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libgda/ruby-libgda-0.14.1.ebuild,v 1.1 2005/11/15 10:49:57 citizen428 Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby libgda (GNOME-DB) bindings"
KEYWORDS="~alpha ~ia64 ~ppc ~sparc ~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND=">=gnome-extra/libgda-1.0.3"
RDEPEND=">=dev-ruby/ruby-glib2-${PV}"

