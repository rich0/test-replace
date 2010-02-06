# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/drqueue/drqueue-9999.ebuild,v 1.2 2010/02/06 02:54:15 sping Exp $

EAPI="2"

inherit eutils distutils git

DESCRIPTION="Render farm managing software"
HOMEPAGE="http://www.drqueue.org/"
EGIT_REPO_URI="git://gitorious.org/drqueue-git/drqueue-git.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="X python ruby"

RDEPEND="X? ( >=x11-libs/gtk+-2 )
	 python? ( dev-lang/python )
	 ruby? ( dev-lang/ruby )
	 app-shells/tcsh"

DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	ruby? ( dev-lang/swig )
	python? ( >=dev-python/setuptools-0.6_rc6 )
	>=dev-util/scons-0.97"

pkg_setup() {
	enewgroup drqueue
	enewuser drqueue -1 /bin/bash /dev/null daemon,drqueue
}

src_compile() {
	if use X; then
		scons ${MAKEOPTS} build_drman=yes || die "scons failed"
	else
		scons ${MAKEOPTS} build_drqman=no || die "scons failed"
	fi

	if use python; then
		einfo "compiling python bindings"
		cd "${S}"/python/
		distutils_src_compile
	fi

	if use ruby; then
		einfo "compiling ruby bindings"
		cd "${S}"/ruby/
		ruby extconf.rb
		emake || die "emake failed"
	fi
}

pkg_preinst() {
	# stop daemons since script is being updated
	[ -n "$(pidof drqsd)" -a -x /etc/init.d/drqsd ] && \
			/etc/init.d/drqsd stop
	[ -n "$(pidof drqmd)" -a -x /etc/init.d/drqmd ] && \
			/etc/init.d/drqmd stop
}

src_install() {
	dodir /var/lib
	scons PREFIX="${D}"/var/lib install || die "install failed"

	# not really needed
	rm -R "${D}"/var/lib/drqueue/bin/viewcmd || die "rm failed"

	# install {conf,init,env}.d files
	for i in drqmd drqsd ; do
		newinitd "${FILESDIR}"/${PN}-0.64.3-etc-initd-${i} ${i} || die "newinitd failed"
		newconfd "${FILESDIR}"/${PN}-0.64.3-etc-confd-${i} ${i} || die "newconfd failed"
	done
	newenvd "${FILESDIR}"/${PN}-0.64.3-etc-envd-02drqueue 02drqueue || die "newenvd failed"

	# create the drqueue pid directory
	dodir /var/run/drqueue
	keepdir /var/run/drqueue

	# move logs dir to /var/log
	dodir /var/log
	mv "${D}"/var/lib/drqueue/logs "${D}"/var/log/drqueue

	# fix bins and make links for /usr/bin
	dodir /usr/bin
	local commands=( blockhost cjob jobfinfo \
			jobinfo master requeue sendjob slave )
	if use X ; then
		commands=( ${commands[@]} drqman )
	else
		# Remove drqman leftovers
		for i in etc/drqman.rc etc/drqman.conf bin/drqman ; do
			rm -v "${D}"/var/lib/drqueue/$i || die "rm failed"
		done
	fi
	for cmd in ${commands[@]} ; do
		dosed 's|SHLIB=\$DRQUEUE_ROOT/bin/shlib|SHLIB=/var/lib/drqueue/bin/shlib|' \
				/var/lib/drqueue/bin/${cmd} || die "dosed failed"
		dosym /var/lib/drqueue/bin/${cmd} /usr/bin/ \
				|| die "dosym failed"
	done

	# install documentation
	dodoc AUTHORS ChangeLog INSTALL \
			NEWS README README.mentalray \
			README.python README.shell_variables \
			setenv || die "dodoc failed"

	if use python; then
		cd "${S}"/python/
		distutils_src_install
		dodir /var/lib/${PN}/python

		# Install DRKeewee web service and example python scripts
		insinto /var/lib/${PN}/python
		doins -r DrKeewee examples || die "doins failed"
	fi

	if use ruby; then
		cd "${S}"/ruby/
		emake DESTDIR="${D}" install || die "emake failed"
	fi
}

pkg_postinst() {
	einfo "Edit /etc/conf.d/drqsd /etc/env.d/02drqueue"
	einfo "and /etc/conf.d/drqmd DRQUEUE_MASTER=\"hostname\""
	einfo "to reflect your master's hostname."
	if use python ; then
		einfo ""
		einfo "DrKeewee can be found in /var/lib/drqueue/python"

		python_mod_optimize "$(python_get_sitedir)"/drqueue
	fi
}

pkg_postrm() {
	use python && python_mod_cleanup "$(python_get_sitedir)"/drqueue
}
