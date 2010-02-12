# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sysinfo/sysinfo-0.7.1.ebuild,v 1.1 2010/02/12 22:44:31 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST=""
RESTRICT=test

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc"

RUBY_FAKEGEM_BINWRAP="sysinfo"

inherit ruby-fakegem eutils

DESCRIPTION="All your system-independent info in one handy class"
HOMEPAGE="http://solutious.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/storable dev-ruby/drydock"

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-hanna.patch
}
