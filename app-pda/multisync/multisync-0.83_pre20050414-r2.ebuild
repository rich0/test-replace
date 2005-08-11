# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/multisync/multisync-0.83_pre20050414-r2.ebuild,v 1.4 2005/08/11 15:08:21 swegener Exp $

inherit versionator kde-functions

CVS_VERSION="${PV/*_pre/}"
S=${WORKDIR}/${PN}
export WANT_AUTOMAKE=1.7

DESCRIPTION="Modular sync client which supports an array of plugins."
HOMEPAGE="http://multisync.sourceforge.net/"
SRC_URI="mirror://gentoo/${PN}-${CVS_VERSION}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE="evo irmc ldap bluetooth pda kdepim"
# evo    - evolution plugin
# irmc   - bluetooth/irmc/irda plugin ( local )
# pda    - opie plugin                ( local )
# ldap   - ldap plugin - experimental
# kdepim - sync with the kdepim app

DEPEND=">=gnome-base/libbonobo-2.2
		>=gnome-base/libgnomeui-2.2
		>=gnome-base/libgnome-2.2
		>=dev-libs/glib-2
		>=gnome-base/gconf-2
		>=gnome-base/gnome-vfs-2.2
		>=gnome-base/orbit-2.8.2
		>=dev-libs/openssl-0.9.6j
		evo?  ( mail-client/evolution )
		irmc? ( >=net-wireless/irda-utils-0.9.15
				>=dev-libs/openobex-1
				bluetooth? ( 	>=net-wireless/bluez-libs-2.7
				         		>=net-wireless/bluez-utils-2.7 ) )
		pda? ( >=net-misc/curl-7.10.5
				app-pda/pilot-link )
		kdepim? ( || ( kde-base/kdepim kde-base/kdepim-meta ) )
		ldap? ( >=net-nds/openldap-2.0.27
				>=dev-libs/cyrus-sasl-2.1.4 )"

make_plugin_list() {
	local evoversion

	PLUGINS="backup_plugin syncml_plugin"
	if use evo
	then
		evoversion="$(best_version mail-client/evolution)"
		# remove prefix
		evoversion=${evoversion//*evolution-}
		# remove revisions
		evoversion=${evoversion//-*}
		# find major
		evoversion=$(get_major_version ${evoversion})

		[[ ${evoversion} -eq 2 ]] 	&& PLUGINS="${PLUGINS} evolution2_sync"
		[[ ${evoversion} -eq 1 ]] 	&& PLUGINS="${PLUGINS} evolution_sync"
	fi
	use irmc 	&& PLUGINS="${PLUGINS} irmc_sync"
	use pda 	&& PLUGINS="${PLUGINS} opie_sync palm_sync"
	use ldap 	&& PLUGINS="${PLUGINS} ldap_plugin"
	use kdepim	&& PLUGINS="${PLUGINS} kdepim_plugin"
}

run_compile() {
	aclocal || die "failed aclocal"
	libtoolize --copy --force || die "libtoolize failed!"
	autoheader || die "Failed during autoheader!"
	automake --add-missing --gnu || die "Failed during automake!"
	autoconf || die "Failed during autoconf!"
	econf CPPFLAGS="${myInc} ${CPPFLAGS}" || die "Failed during econf!"
	make || die "Failed during make!"
}

src_compile() {
	[[ -z ${PLUGINS} ]] && make_plugin_list

	einfo "Building Multisync with these plugins:"
	for plugin_dir in ${PLUGINS}; do
		einfo "      ${plugin_dir}"
	done

	cd ${S}
	if use kdepim; then
		set-qtdir 3
		set-kdedir 3
		myInc="-I${KDEDIR}/include ${myInc}"
	fi
	use pda && myInc="-I/usr/include/libpisock ${myInc}"
	run_compile;
	for plugin_dir in ${PLUGINS}; do
		einfo "Building ${plugin_dir}"
		cd ${S}/plugins/${plugin_dir}
		run_compile;
	done
}

src_install() {
	[[ -z ${PLUGINS} ]] && make_plugin_list

	einstall || die "Multisync install failed!"
	for plugin_dir in ${PLUGINS}; do
		cd ${S}/plugins/${plugin_dir}
		make install DESTDIR=${D} || die "${plugin_dir} make install failed!"
	done
}
