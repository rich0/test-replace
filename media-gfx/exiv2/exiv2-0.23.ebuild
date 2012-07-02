# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/exiv2/exiv2-0.23.ebuild,v 1.2 2012/07/02 20:33:22 ssuominen Exp $

EAPI=4
AUTOTOOLS_IN_SOURCE_BUILD=1

inherit eutils autotools-utils multilib toolchain-funcs python

DESCRIPTION="EXIF and IPTC metadata C++ library and command line utility"
HOMEPAGE="http://www.exiv2.org/"
SRC_URI="http://www.exiv2.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE_LINGUAS="de es fi fr pl ru sk"
IUSE="contrib doc examples nls xmp zlib static-libs $(printf 'linguas_%s ' ${IUSE_LINGUAS})"

RDEPEND="
	virtual/libiconv
	nls? ( virtual/libintl )
	xmp? ( dev-libs/expat )
	zlib? ( sys-libs/zlib )
"
DEPEND="${RDEPEND}
	contrib? ( >=dev-libs/boost-1.37 )
	doc? (
		app-doc/doxygen
		dev-libs/libxslt
		dev-util/pkgconfig
		media-gfx/graphviz
		=dev-lang/python-2*
	)
	nls? ( sys-devel/gettext )
"

DOCS=( README doc/ChangeLog doc/cmd.txt )

src_prepare() {
	# exiv2 fails to build with boost-1.46 due to boost filesystem
	# API v3 becoming the default. This is easily fixed by adding a
	#  #define BOOST_FILESYSTEM_VERSION 2
	# to source files that include boost/filesystem.hpp
	#
	# Implemented via sed to avoid patch-file (bug #357605)
	sed -i -e \
		's|^\(#include <boost/filesystem.hpp>.*\)|#define BOOST_FILESYSTEM_VERSION 2\n\1|g' \
		contrib/organize/helpers.hpp

	# convert docs to UTF-8
	local i
	for i in doc/cmd.txt; do
		einfo "Converting "${i}" to UTF-8"
		iconv -f LATIN1 -t UTF-8 "${i}" > "${i}~" && mv -f "${i}~" "${i}" || rm -f "${i}~"
	done

	if use doc; then
		einfo "Updating doxygen config"
		doxygen 2>&1 >/dev/null -u config/Doxyfile
		python_convert_shebangs -r 2 doc/templates
	fi

	if use contrib; then
		# create build environment for contrib
		ln -snf ../../src contrib/organize/exiv2
		sed -i -e 's:/usr/local/include/.*:/usr/include:g' \
			-e 's:/usr/local/lib/lib:-l:g' -e 's:-gcc..-mt-._..\.a::g' \
			contrib/organize/boost.mk
	fi
}

src_configure() {
	local myeconfargs=(
		$(use_enable nls)
		$(use_enable xmp)
		$(use_enable static-libs static)
	)

	# plain 'use_with' fails
	use zlib || myeconfargs+=("${myconf} --without-zlib")

	# Bug #78720. amd64/gcc-3.4/-fvisibility* fail.
	if [ $(gcc-major-version) -lt 4 ]; then
		use amd64 && myeconfargs+=("${myconf} --disable-visibility")
	fi

	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile

	if use contrib; then
		emake -C contrib/organize \
			LDFLAGS="\$(BOOST_LIBS) -L../../src -lexiv2 ${LDFLAGS}" \
			CPPFLAGS="${CPPFLAGS} -I\$(BOOST_INC_DIR) -I. -DEXV_HAVE_STDINT_H" \
		|| die "emake organize failed"
	fi

	if use doc; then
		emake doc || die "emake doc failed"
	fi
}

src_install() {
	autotools-utils_src_install

	if use contrib; then
		emake DESTDIR="${D}" -C contrib/organize install || die "emake install organize failed"
	fi

	use xmp && dodoc doc/{COPYING-XMPSDK,README-XMP,cmdxmp.txt}
	use doc && dohtml -r doc/html/.
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		docompress -x /usr/share/doc/${PF}/examples
		doins samples/*.cpp
	fi
}
