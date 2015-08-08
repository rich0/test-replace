# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_RECIPE_TEST=""
RUBY_FAKEGEM_RECIPE_DOC=""

inherit ruby-fakegem

DESCRIPTION="Faster string escaping routines for your ruby apps"
HOMEPAGE="https://github.com/brianmario/escape_utils"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/minitest:5 )"

all_ruby_prepare() {
	sed -i -e "/bundler/d" test/helper.rb || die
}

each_ruby_configure() {
	${RUBY} -Cext/escape_utils extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext/escape_utils
	cp ext/escape_utils/escape_utils$(get_modname) lib/escape_utils || die
}

each_ruby_test() {
	for i in test/*/*_test.rb; do
		${RUBY} -Ilib:test $i || die
	done
}
