# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MODULE_AUTHOR=MGRIMES
MODULE_VERSION=1.54
inherit perl-module

DESCRIPTION="A client library for the Linux Infrared Remote Control (LIRC)"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/File-Path-Expand
	dev-perl/Class-Accessor"
DEPEND="${RDEPEND}
	dev-perl/Module-Build"

# tests succeed - only tested without lirc - tove
#SRC_TEST=do
