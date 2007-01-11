# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tracker/tracker-0.5.3.ebuild,v 1.1 2007/01/11 02:18:51 compnerd Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit autotools eutils flag-o-matic linux-info

DESCRIPTION="A tagging metadata database, search tool and indexer"
HOMEPAGE="http://www.gnome.org/~jamiemcc/tracker/"
SRC_URI="http://www.gnome.org/~jamiemcc/tracker/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug fam gnome gsf gstreamer jpeg pdf thumbnailing test xine"

RDEPEND=">=dev-libs/glib-2.12.0
		 >=x11-libs/pango-1.0.0
		 >=dev-libs/gmime-2.1.0
		 || (
				>=dev-libs/dbus-glib-0.71
				( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.60 )
			)
		 >=dev-db/sqlite-3.2
		 >=media-libs/libpng-1.2
		 fam? ( >=app-admin/gamin-0.1.7 )
		 gnome? (
					>=x11-libs/gtk+-2.8
					>=gnome-base/libglade-2.5
					>=gnome-base/libgnome-2.14
					>=gnome-base/gnome-vfs-2.10
					>=gnome-base/libgnomeui-2.14
					>=gnome-base/gnome-desktop-2.14
				)
		 gsf? ( >=gnome-extra/libgsf-1.13 )
		 gstreamer? ( >=media-libs/gstreamer-0.10 )
		 jpeg? ( >=media-gfx/exif-0.6 )
		 pdf?	(
		 			>=x11-libs/cairo-1.0
					>=app-text/poppler-bindings-0.5.0
				)
		 thumbnailing? ( >=media-gfx/imagemagick-5.2.1 )
		 xine? ( >=media-libs/xine-lib-1.0 )"

DEPEND="${RDEPEND}
		>=dev-util/intltool-0.22
		>=sys-devel/gettext-0.14
		>=dev-util/pkgconfig-0.20"

function notify_inotify() {
	ewarn
	ewarn "You should enable the INOTIFY support in your kernel."
	ewarn "Check the 'Inotify file change notification support' under the"
	ewarn "'File systems' option.  It is marked as CONFIG_INOTIFY in the config"
	ewarn "Also enable 'Inotify support for userland' in under the previous"
	ewarn "option.  It is marked as CONFIG_INOTIFY_USER in the config."
	ewarn
	ebeep 5
}

function inotify_enabled() {
	linux_chkconfig_present INOTIFY && linux_chkconfig_present INOTIFY_USER
}

pkg_setup() {
	linux-info_pkg_setup

	if built_with_use 'dev-db/sqlite' 'nothreadsafe' ; then
		eerror "You must build sqlite with threading support"
		die "dev-db/sqlite built with nothreadsafe"
	fi

	if ! built_with_use 'app-text/poppler-bindings' 'gtk' ; then
		ewarn "You must build poppler-bindings with gtk to get support for PDFs"
		die "poppler-bindings needs gtk support"
	fi

	if use thumbnailing ; then
		if ! built_with_use 'media-gfx/imagemagick' 'png' ; then
			ewarn "You must build imagemagick with png"
			die "imagemagick needs png support"
		fi

		if use jpeg && ! built_with_use 'media-gfx/imagemagick' 'jpeg' ; then
			ewarn "You must build imagemagick with jpeg to get support for JPEG"
			die "imagemagick needs jpeg support"
		fi
	fi

	if use fam ; then
		ebeep 5
		ewarn "You are selecting to build tracker with FAM support rather than"
		ewarn "inotify. It is highly recommended that you use inotify over FAM."
		epause 5
	else
		inotify_enabled || notify_inotify
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-0.5.3-requires-libpng.patch
	epatch ${FILESDIR}/${PN}-0.5.3-disable-tests.patch
	epatch ${FILESDIR}/${PN}-0.5.3-disable-debug.patch
	epatch ${FILESDIR}/${PN}-0.5.3-imagemagick-5.2.1-needed.patch
	epatch ${FILESDIR}/${PN}-0.5.3-trackerd-test-compile-fix.patch
	epatch ${FILESDIR}/${PN}-0.5.3-delete-services-missing.patch
	epatch ${FILESDIR}/${PN}-0.5.3-thumbnailer-create-dir.patch
	epatch ${FILESDIR}/${PN}-0.5.3-remove-mysql.patch
	epatch ${FILESDIR}/${PN}-0.5.3-sqlite-cleanups.patch
	epatch ${FILESDIR}/${PN}-0.5.3-convert-pdf-thumbnailer.patch

	rm ${S}/data/mysql-*.sql

	eautoreconf
}

src_compile() {
	local myconf="--enable-external-sqlite"

	if use gstreamer ; then
		myconf="${myconf} --enable-video-extractor=gstreamer"
	elif use xine ; then
		myconf="${myconf} --enable-video-extractor=xine"
	fi

	if use fam ; then
		myconf="${myconf} --enable-file-monitoring=fam"
	elif inotify_enabled ; then
		myconf="${myconf} --enable-file-monitoring=inotify"
	else
		myconf="${myconf} --enable-file-monitoring=polling"
	fi

	econf ${myconf} \
		  $(use_enable debug debug-code) \
		  $(use_enable gnome gui) \
		  $(use_enable jpeg exif) \
		  $(use_enable pdf) \
		  $(use_enable test) \
		|| die "configure failed"

	emake || die "build failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	einfo "Evince and imagemagick are pure runtime depdencies, and as such, you"
	einfo "may add or remove them without rebuilding this package."
}
