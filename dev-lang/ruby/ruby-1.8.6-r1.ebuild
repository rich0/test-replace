# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.8.6-r1.ebuild,v 1.4 2007/06/07 17:12:50 gustavoz Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

# A new version is needed for 1.8.6, currently disabled.
ONIGURUMA="onigd2_5_8"

inherit flag-o-matic alternatives eutils multilib autotools versionator

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="ftp://ftp.ruby-lang.org/pub/ruby/$(get_version_component_range 1-2)/${P}.tar.gz"
#	cjk? ( http://www.geocities.jp/kosako3/oniguruma/archive/${ONIGURUMA}.tar.gz )"

LICENSE="Ruby"
SLOT="1.8"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="debug doc examples ipv6 rubytests socks5 threads tk" # cjk
RESTRICT="confcache"

RDEPEND=">=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	socks5? ( >=net-proxy/dante-1.1.13 )
	tk? ( dev-lang/tk )
	>=dev-ruby/ruby-config-0.3.1
	!=dev-lang/ruby-cvs-1.8*
	!dev-ruby/rdoc
	!dev-ruby/rexml"
DEPEND="${RDEPEND}"
PROVIDE="virtual/ruby"

src_unpack() {
	unpack ${A}

#	if use cjk ; then
#		einfo "Applying ${ONIGURUMA}"
#		pushd ${WORKDIR}/oniguruma
##		epatch ${FILESDIR}/oniguruma-2.3.1-gentoo.patch
#		econf --with-rubydir=${S} || die "econf failed"
#		MY_PV=$(get_version_component_range 1-2)
#		make ${MY_PV/./}
#		popd
#	fi

	cd "${S}"

	# Fix a hardcoded lib path in configure script
	sed -i -e "s:\(RUBY_LIB_PREFIX=\"\${prefix}/\)lib:\1$(get_libdir):" \
		configure.in || die "sed failed"

	eautoreconf

	epatch ${FILESDIR}/${P}-exit-status.patch
}

src_compile() {
	# -fomit-frame-pointer makes ruby segfault, see bug #150413.
	filter-flags -fomit-frame-pointer
	# In many places aliasing rules are broken; play it safe
	# as it's risky with newer compilers to leave it as it is.
	append-flags -fno-strict-aliasing

	# Socks support via dante
	if use socks5 ; then
		# Socks support can't be disabled as long as SOCKS_SERVER is
		# set and socks library is present, so need to unset
		# SOCKS_SERVER in that case.
		unset SOCKS_SERVER
	fi

	# Increase GC_MALLOC_LIMIT if set (default is 8000000)
	if [ -n "${RUBY_GC_MALLOC_LIMIT}" ] ; then
		append-flags "-DGC_MALLOC_LIMIT=${RUBY_GC_MALLOC_LIMIT}"
	fi

	econf --program-suffix=${SLOT/./} --enable-shared \
		$(use_enable socks5 socks) \
		$(use_enable doc install-doc) \
		$(use_enable threads pthread) \
		$(use_enable ipv6 ipv6) \
		$(use_enable debug debug) \
		$(use_with tk) \
		--with-sitedir=/usr/$(get_libdir)/ruby/site_ruby \
		|| die "econf failed"

	emake || die "emake failed"
}

src_test() {
	emake -j1 test || die "make test failed"

	elog "Ruby's make test has been run. Ruby also ships with a make check"
	elog "that cannot be run until after ruby has been installed."
	elog
	if use rubytests; then
		elog "You have enabled rubytests, so they will be installed to"
		elog "/usr/share/${PN}-${SLOT}/test. To run them you must be a user other"
		elog "than root, and you must place them into a writeable directory."
		elog "Then call: "
		elog
		elog "ruby -C /location/of/tests runner.rb"
	else
		elog "Enable the rubytests USE flag to install the make check tests"
	fi
}

src_install() {
	LD_LIBRARY_PATH=${D}/usr/$(get_libdir)
	RUBYLIB="${S}:${D}/usr/$(get_libdir)/ruby/${SLOT}"
	for d in $(find ${S}/ext -type d) ; do
		RUBYLIB="${RUBYLIB}:$d"
	done
	export LD_LIBRARY_PATH RUBYLIB

	make DESTDIR="${D}" install || die "make install failed"

	MINIRUBY=$(echo -e 'include Makefile\ngetminiruby:\n\t@echo $(MINIRUBY)'|make -f - getminiruby)
	keepdir $(${MINIRUBY} -rrbconfig -e "print Config::CONFIG['sitelibdir']")
	keepdir $(${MINIRUBY} -rrbconfig -e "print Config::CONFIG['sitearchdir']")

	if use doc; then
		make DESTDIR="${D}" install-doc || die "make install-doc failed"
	fi

	if use examples; then
		dodir /usr/share/doc/${PF}
		cp -pPR sample ${D}/usr/share/doc/${PF}
	fi

	dosym libruby${SLOT/./}$(get_libname ${PV%_*}) /usr/$(get_libdir)/libruby$(get_libname ${PV%.*})
	dosym libruby${SLOT/./}$(get_libname ${PV%_*}) /usr/$(get_libdir)/libruby$(get_libname ${PV%_*})

	dodoc ChangeLog NEWS README* ToDo

	if use rubytests; then
		dodir /usr/share/${PN}-${SLOT}
		cp -pPR test ${D}/usr/share/${PN}-${SLOT}
	fi
}

pkg_postinst() {
	ewarn
	ewarn "Warning: Vim won't work if you've just updated ruby from"
	ewarn "1.6.x to 1.8.x due to the library version change."
	ewarn "In that case, you will need to remerge vim."
	ewarn

	ewarn "If you upgrade to >=sys-apps/coreutils-6.7-r1,"
	ewarn "you should re-emerge ruby again."
	ewarn "See bug #159922 for details"
	ewarn
	if [ ! -n "$(readlink ${ROOT}usr/bin/ruby)" ] ; then
		${ROOT}usr/sbin/ruby-config ruby${SLOT/./}
	fi
	elog
	elog "You can change the default ruby interpreter by ${ROOT}usr/sbin/ruby-config"
	elog
}

pkg_postrm() {
	if [ ! -n "$(readlink ${ROOT}usr/bin/ruby)" ] ; then
		${ROOT}usr/sbin/ruby-config ruby${SLOT/./}
	fi
}
