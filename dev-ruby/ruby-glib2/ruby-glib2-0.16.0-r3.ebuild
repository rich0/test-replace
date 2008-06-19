# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-glib2/ruby-glib2-0.16.0-r3.ebuild,v 1.5 2008/06/19 19:27:27 armin76 Exp $

inherit ruby ruby-gnome2 eutils

DESCRIPTION="Ruby Glib2 bindings"
KEYWORDS="alpha amd64 ia64 ~ppc sparc ~x86"
IUSE=""
USE_RUBY="ruby18"

RDEPEND=">=dev-libs/glib-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PATCHES="${FILESDIR}/ruby-glib2-0.16.0-glib-2.14.patch \
	${FILESDIR}/ruby-glib2-0.16.0-glib-2.16.patch \
	${FILESDIR}/ruby-glib2-0.16.0-typedef.patch"
