# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/secpolicy/secpolicy-0.0.1.ebuild,v 1.4 2002/07/17 20:43:17 drobbins Exp $

PARENT="kde-base/kdeadmin/kdeadmin-3.0-r1.ebuild"
inherit kde-child

DESCRIPTION="kdeadmin - lilo-config: kcontrol module for lilo configuration"

newdepend "pam? ( >=sys-libs/pam-0.72 )"
use pam	&& myconf="$myconf --with-pam"	|| myconf="$myconf --without-pam --with-shadow"

