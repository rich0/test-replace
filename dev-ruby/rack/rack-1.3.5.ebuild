# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rack/rack-1.3.5.ebuild,v 1.1 2011/12/24 08:03:02 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="ChangeLog KNOWN-ISSUES README.rdoc SPEC"

inherit ruby-fakegem eutils versionator

DESCRIPTION="A modular Ruby webserver interface"
HOMEPAGE="http://rubyforge.org/projects/rack"
SRC_URI="mirror://rubyforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend "virtual/ruby-ssl"

# The gem has automagic dependencies over mongrel, ruby-openid,
# memcache-client, thin, mongrel and camping; not sure if we should
# make them dependencies at all. We do add the fcgi dependency because
# that spec isn't optional.
ruby_add_bdepend "test? ( dev-ruby/bacon dev-ruby/ruby-fcgi )"

# Block against versions in older slots that also try to install a binary.
RDEPEND="${RDEPEND} !<dev-ruby/rack-1.1.0-r1:0 !<dev-ruby/rack-1.2.4-r2:1.2"

all_ruby_prepare() {
	epatch "${FILESDIR}"/${PN}-1.2.1-gentoo.patch
}

each_ruby_prepare() {
	case ${RUBY} in
		*jruby)
			# Avoid two failing tests due to bugs in jruby that should
			# be solved in 1.6.5 or 1.7.
			rm test/spec_deflater.rb || die
			;;
		*)
			;;
	esac
}

each_ruby_test() {
	# Since the Rakefile calls specrb directly rather than loading it, we
	# cannot use it to launch the tests or only the currently-selected
	# RUBY interpreter will be tested.
	${RUBY} -S bacon -Ilib -w -a \
		-q -t '^(?!Rack::Handler|Rack::Adapter|Rack::Session::Memcache|Rack::Server)' \
		|| die "test failed for ${RUBY}"
}
