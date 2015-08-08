# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
QT5_MODULE="qttools"
inherit qt5-build

DESCRIPTION="Graphical tool for translating Qt applications"

if [[ ${QT5_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~hppa ~ppc64 ~x86"
fi

IUSE=""

DEPEND="
	>=dev-qt/designer-${PV}:5
	>=dev-qt/qtcore-${PV}:5
	>=dev-qt/qtgui-${PV}:5
	>=dev-qt/qtprintsupport-${PV}:5
	>=dev-qt/qtwidgets-${PV}:5
	>=dev-qt/qtxml-${PV}:5
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/linguist/linguist
)
