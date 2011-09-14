# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/fence-agents/fence-agents-3.1.5.ebuild,v 1.1 2011/09/14 10:34:42 ultrabug Exp $

EAPI=4

inherit multilib versionator

CLUSTER_RELEASE="${PV}"
MY_P="cluster-${CLUSTER_RELEASE}"

MAJ_PV="$(get_major_version)"
MIN_PV="$(get_version_component_range 2-3)"

DESCRIPTION="Cluster Fencing Agents"
HOMEPAGE="https://fedorahosted.org/cluster/wiki/HomePage"
SRC_URI="https://fedorahosted.org/releases/f/e/${PN}/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="~sys-cluster/libccs-${PV}"
DEPEND="${RDEPEND}
	dev-python/pexpect
	dev-libs/libxslt
	dev-python/pexpect
	dev-python/pycurl
	dev-python/suds"

src_configure() {
	econf \
		--docdir=/usr/share/doc/${P} \
		--libdir=/usr/$(get_libdir) \
		--localstatedir=/var
}

pkg_postinst() {
	if [[ "${ROOT}" != "/" ]] ; then
		ewarn "You have to run 'ccs_update_schema' in the chroot-environment"
		ewarn "to update the schema file for the cluster configuration."
		ewarn "Otherwise you will not be able to define ressources."
	else
		elog "Running ccs_update_schema to update the configuration file schema"
		/usr/sbin/ccs_update_schema -v -f
	fi
}

pkg_postrm() {
	if [[ "${ROOT}" != "/" ]] ; then
		ewarn "You have to run 'ccs_update_schema' in the chroot-environment"
		ewarn "to update the schema file for the cluster configuration."
		ewarn "Otherwise you may be able to define ressources even though they"
		ewarn "are not present anymore."
	else
		elog "Running ccs_update_schema to update the configuration file schema"
		/usr/sbin/ccs_update_schema -v -f
	fi
}
