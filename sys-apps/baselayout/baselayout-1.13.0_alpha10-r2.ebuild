# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout/baselayout-1.13.0_alpha10-r2.ebuild,v 1.3 2006/12/30 12:11:29 uberlord Exp $

inherit flag-o-matic eutils toolchain-funcs multilib

DESCRIPTION="Filesystem baselayout and init scripts"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~uberlord/baselayout/${P}.tar.bz2
	http://dev.gentoo.org/~azarah/baselayout/${P}.tar.bz2
	http://dev.gentoo.org/~vapier/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="bootstrap build pam static unicode kernel_linux kernel_FreeBSD"

# This version of baselayout needs awk in /bin, but as we do not have
# a c++ compiler during bootstrap, we cannot depend on it if "bootstrap"
# or "build" are in USE.
RDEPEND="virtual/init
		!build? (
			!bootstrap? (
				>=sys-libs/readline-5.0-r1
				>=app-shells/bash-3.2_p3-r1
				kernel_linux? (
					>=sys-apps/coreutils-5.2.1
				)
				kernel_FreeBSD? (
					sys-process/fuser-bsd
					sys-process/pidof-bsd
				)
			)
		)
		pam? ( virtual/pam )
		!<net-misc/dhcpcd-2.0.0"
DEPEND="virtual/os-headers"
PROVIDE="virtual/baselayout"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-r2440.patch"
	epatch "${FILESDIR}/${P}-pidfile.patch"

	# Setup unicode defaults for silly unicode users
	if use unicode ; then
		sed -i -e '/^UNICODE=/s:no:yes:' etc/rc.conf
	fi

	# SPARC does not like stty, so we disable RC_INTERACTIVE which requires it
	# see Gentoo bug #104067.
	if use sparc ; then \
		sed -i -e  '/^KEYMAP=/s:us:sunkeymap:' etc/conf.d/keymaps || die
		sed -i -e '/^RC_INTERACTIVE=/s:yes:no:' etc/conf.d/rc || die
	fi
}

make_opts() {
	# Standard options
	local opts="DESTDIR=\"${ROOT}\" ARCH=\"$(tc-arch)\" CC=\"$(tc-getCC)\""
	local libdir="lib"

	[[ ${SYMLINK_LIB} == "yes" ]] && libdir=$(get_abi_LIBDIR "${DEFAULT_ABI}")

	opts="${opts} LIB=${libdir}"

	if use kernel_linux ; then
		opts="${opts} OS=Linux"
	else
		opts="${opts} OS=BSD"
	fi

	use pam && opts="${opts} HAVE_PAM=1"

	echo "${opts}"
}

src_compile() {
	use static && append-ldflags -static
	emake $(make_opts) || die
}

# Support function for remapping old wireless dns vars
remap_dns_vars() {
	if [[ -f "${ROOT}/etc/conf.d/$1" ]]; then
		sed -e 's/\<domain_/dns_domain_/g' \
			-e 's/\<mac_domain_/mac_dns_domain_/g' \
			-e 's/\<nameservers_/dns_servers_/g' \
			-e 's/\<mac_nameservers_/mac_dns_servers_/g' \
			-e 's/\<searchdomains_/dns_search_domains_/g' \
			-e 's/\<mac_searchdomains_/mac_dns_search_domains_/g' \
			"${ROOT}/etc/conf.d/$1" > "${IMAGE}/etc/conf.d/$1"
	fi
}

pkg_preinst() {
	# Move our makefiles to a temporay location
	mv "${D}"/usr/share/baselayout/{Makefile,default.mk,runlevels}* "${T}"

	# We need to install directories and maybe some dev nodes when building
	# stages, but they cannot be in CONTENTS.
	# Also, we cannot reference $S as binpkg will break so we do this.
	if use build || use bootstrap ; then
		local libdirs="$(get_all_libdirs)" dir=
		# Create our multilib dirs - the Makefile has no knowledge of this
		: ${libdirs:=lib}	# it isn't that we don't trust multilib.eclass...
		for dir in ${libdirs}; do
			mkdir -p "${ROOT}${dir}"
			touch "${ROOT}${dir}"/.keep
			mkdir -p "${ROOT}usr/${dir}"
			touch "${ROOT}usr/${dir}"/.keep
			mkdir -p "${ROOT}usr/local/${dir}"
			touch "${ROOT}usr/local/${dir}"/.keep
		done

		# Ugly compatibility with stupid ebuilds and old profiles symlinks
		if [[ ${SYMLINK_LIB} == "yes" ]] ; then
			rm -r "${ROOT}"/{lib,usr/lib,usr/local/lib} &> /dev/null
			local lib=$(get_abi_LIBDIR ${DEFAULT_ABI})
			ln -s "${lib}" "${ROOT}lib"
			ln -s "${lib}" "${ROOT}usr/lib"
			ln -s "${lib}" "${ROOT}usr/local/lib"
		fi

		make -C "${T}" $(make_opts) layout || die "failed to layout filesystem"
	fi

	# Change some vars introduced in baselayout-1.11.0 before we go stable
	# The new names make more sense and allow nis_domain
	# for use in baselayout-1.12.0
	remap_dns_vars net
	remap_dns_vars wireless
}

src_install() {
	make $(make_opts) DESTDIR="${D}" install
	dodoc ChangeLog COPYRIGHT

	# Should this belong in another ebuild? Like say binutils?
	# List all the multilib libdirs in /etc/env/04multilib (only if they're
	# actually different from the normal
	if has_multilib_profile || [[ $(get_libdir) != "lib" || -n ${CONF_MULTILIBDIR} ]]; then
		local libdirs="$(get_all_libdirs)" libdirs_env= dir=
		: ${libdirs:=lib}	# it isn't that we don't trust multilib.eclass...
		for dir in ${libdirs}; do
			libdirs_env=${libdirs_env:+$libdirs_env:}/${dir}:/usr/${dir}:/usr/local/${dir}
		done

		# Special-case uglyness... For people updating from lib32 -> lib amd64
		# profiles, keep lib32 in the search path while it's around
		if has_multilib_profile && [[ -d ${ROOT}lib32 || -d ${ROOT}lib32 ]] && ! hasq lib32 ${libdirs}; then
			libdirs_env="${libdirs_env}:/lib32:/usr/lib32:/usr/local/lib32"
		fi
		echo "LDPATH=\"${libdirs_env}\"" > "${T}"/04multilib
		doenvd "${T}"/04multilib
	fi

	# rc-scripts version for testing of features that *should* be present
	echo "Gentoo Base System version ${PV}" > "${D}"/etc/gentoo-release

	# Remove the installed runlevels, as we don't know about $ROOT yet
	rm -rf "${D}/etc/runlevels"

	# Copy the make files to /usr/share/baselayout so we can re-use them in
	# postinst, otherwise binpkg will break.
	insinto /usr/share/baselayout
	doins -r Makefile default.mk runlevels*
}

pkg_postinst() {
	# Punt this when MAKEDEV does this
	if use kernel_linux ; then
		if use build || use bootstrap ; then
			# Create base directories
			if [[ ! -e ${ROOT}/dev/.udev && ! -e ${ROOT}/dev/.devfsd ]] ; then
				einfo "Creating dev nodes"
				PATH="${ROOT}"/sbin:${PATH} make -C "${T}" $(make_opts) \
				dev || die "failed to create /dev nodes"
			fi
		fi
	fi

	# Make our runlevels if they don't exist
	if [[ ! -e ${ROOT}etc/runlevels ]] ; then
		einfo "Making default runlevels"
		make -C "${T}" $(make_opts) runlevels_install >/dev/null
	fi

	# We installed some files to /usr/share/baselayout instead of /etc to stop
	# (1) overwriting the user's settings
	# (2) screwing things up when attempting to merge files
	# (3) accidentally packaging up personal files with quickpkg
	# If they don't exist then we install them
	for x in master.passwd passwd shadow group fstab ; do
		[[ -e "${ROOT}etc/${x}" ]] && continue
		[[ -e "${ROOT}usr/share/baselayout/${x}" ]] || continue
		cp -p "${ROOT}usr/share/baselayout/${x}" ${ROOT}etc
	done

	# We need to copy svcdir if upgrading
	if has_version "<sys-apps/${PN}-1.13.0_alpha" ; then
		(
		source "${ROOT}etc/conf.d/rc"
		svcdir="${svcdir:-/var/lib/init.d}"
		einfo "Moving state from ${ROOT}${svcdir} to ${ROOT}lib/rcscripts/init.d"
		cp -RPp "${ROOT}${svcdir}"/* "${ROOT}"lib/rcscripts/init.d
		)
		# Install our new init script and mark it started
		if use kernel_linux ; then
			ln -snf ../../init.d/volumes "${ROOT}"etc/runlevels/boot
			ln -snf /etc/init.d/volumes "${ROOT}"lib/rcscripts/init.d/started
		fi
	fi

	if [[ ${ROOT} == / ]] && ! use build && ! use bootstrap; then
		/sbin/depscan.sh --update >/dev/null
	fi

	# This is also written in src_install (so it's in CONTENTS), but
	# write it here so that the new version is immediately in the file
	# (without waiting for the user to do etc-update)
	rm -f "${ROOT}"/etc/._cfg????_gentoo-release
	echo "Gentoo Base System version ${PV}" > "${ROOT}"/etc/gentoo-release

	echo
	einfo "Please be sure to update all pending '._cfg*' files in /etc,"
	einfo "else things might break at your next reboot!	 You can use 'etc-update'"
	einfo "to accomplish this:"
	einfo
	einfo "	 # etc-update"

	local lo="net.lo0"
	use kernel_linux && lo="net.lo"
	for f in ${ROOT}etc/init.d/net.*; do
		[[ -L ${f} ]] && continue
		echo
		einfo "WARNING: You have older net.* files in ${ROOT}etc/init.d/"
		einfo "They need to be converted to symlinks to ${lo}.	If you haven't"
		einfo "made personal changes to those files, you can update with the"
		einfo "following command:"
		einfo
		einfo "	 /bin/ls ${ROOT}etc/init.d/net.* | grep -v '/${lo}$' | xargs -n1 ln -sfvn ${lo}"
		break
	done

	if sed -e 's/#.*//' "${ROOT}"etc/conf.d/{net,wireless} 2>/dev/null \
		| egrep -q '\<(domain|nameservers|searchdomains)_' ; then
			echo
			ewarn "You have depreciated variables in ${ROOT}etc/conf.d/net"
			ewarn "or ${ROOT}etc/conf.d/wireless"
			ewarn
			ewarn "domain_* -> dns_domain_*"
			ewarn "nameservers_* -> dns_servers_*"
			ewarn "searchdomains_* -> dns_search_domains_*"
			ewarn
			ewarn "They have been converted for you - ensure that you"
			ewarn "update them via 'etc-update'"
	fi

	if sed -e 's/#.*//' "${ROOT}"etc/conf.d/net 2>/dev/null \
		| egrep -q '\<(ifconfig|aliases|broadcasts|netmasks|inet6|ipaddr|iproute)_'; then
			echo
			ewarn "You are using deprecated variables in ${ROOT}etc/conf.d/net"
			ewarn
			ewarn "You are advised to review the new configuration variables as"
			ewarn "found in ${ROOT}etc/conf.d/net.example as there is no"
			ewarn "guarantee that they will work in future versions."
	fi

	# Remove old stuff that may cause problems.
	if [[ -e "${ROOT}"/etc/env.d/01hostname ]] ; then
		rm -f "${ROOT}"/etc/env.d/01hostname
	fi
	if [[ -e "${ROOT}"/etc/init.d/domainname ]] ; then
		rm -f "${ROOT}"/etc/{conf.d,init.d}/domainname \
			"${ROOT}"/etc/runlevels/*/domainname
		echo
		ewarn "The domainname init script has been removed in this version."
		ewarn "Consult ${ROOT}etc/conf.d/net.example for details about how"
		ewarn "to apply dns/nis information to the loopback interface."
	fi

	echo
	einfo "baselayout-1.13 and higher have dropped the RC_STRICT_NET_CHECKING"
	einfo "variable from /etc/conf.d/rc. ${lo} now provides \"net\" and so does"
	einfo "each net script linked to it."
	einfo "The net dependency is now satisfied by any net.* scripts in the default"
	einfo "runlevel, otherwise it's the last net.* script running which includes"
	einfo "${lo}. So if you need to restart a net script that is listed in the"
	einfo "runlevel you are in and not restart anything that needs it then you"
	einfo "will need to use the --nodeps command line option."
}

# Handle our downgraders
# We should remove this when <1.13 has been removed from the tree
pkg_postrm() {
	# Remove dir if downgrading
	if has_version "<sys-apps/${PN}-1.13.0_alpha" ; then
		(
		source "${ROOT}etc/conf.d/rc"
		svcdir="${svcdir:-/var/lib/init.d}"
		einfo "Moving state from ${ROOT}lib/rcscripts/init.d to ${ROOT}${svcdir}"
		mkdir -p "${ROOT}${svcdir}"
		cp -RPp "${ROOT}lib/rcscripts/init.d"/* "${ROOT}${svcdir}"
		umount "${ROOT}lib/rcscripts/init.d" 2>/dev/null
		rm -rf "${ROOT}lib/rcscripts/init.d"
		)
		ewarn "You will need to re-emerge ${PN} to restore ${ROOT}etc/init.d/net.lo"
	fi
}
