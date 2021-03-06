# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Contracts for Java"
HOMEPAGE="https://code.google.com/p/cofoja/"
SRC_URI="https://github.com/nhatminhle/${PN}/archive/v${PV}.zip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RESTRICT="test"

CDEPEND="dev-java/asm:4"
DEPEND=">=virtual/jdk-1.6
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.6
	${CDEPEND}"

S="${WORKDIR}/${P}"

JAVA_GENTOO_CLASSPATH="asm-4"
JAVA_SRC_DIR="src/com/google/java/contract"

# Relies on a bunch of classes in jsr308,
# spec we don't have packaged in Gentoo.. yet.
JAVA_RM_FILES=(
	src/com/google/java/contract/core/apt/JavacUtils.java
)
